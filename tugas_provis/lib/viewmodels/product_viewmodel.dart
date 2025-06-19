import 'package:flutter/foundation.dart';
import 'package:tugas_provis/models/product_model.dart';
import 'package:tugas_provis/services/supabase_services.dart';

class ProductViewModel extends ChangeNotifier {
  final _supabaseService = SupabaseService();

  bool _isLoading = true; // Langsung true saat pertama kali dibuat
  List<ProductModel> _products = [];
  String? _errorMessage;

// State baru untuk hasil pencarian
  List<ProductModel> _searchResults = [];
  bool _isSearching = false;

  bool get isLoading => _isLoading;
  List<ProductModel> get products => _products;
  String? get errorMessage => _errorMessage;

  List<ProductModel> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  ProductModel? _selectedProduct;
  ProductModel? get selectedProduct => _selectedProduct;

  Future<void> fetchProducts() async {
    // Tidak perlu set isLoading ke true lagi karena sudah default
    try {
      _products = await _supabaseService.getProducts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Beri tahu UI untuk update
    }
  }
  // Fungsi baru untuk menjalankan pencarian
  Future<void> performSearch(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }
    _isSearching = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _supabaseService.searchProducts(query);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }
  // Fungsi untuk membersihkan hasil pencarian dan kembali ke daftar semua produk
  void clearSearch() {
    _searchResults = [];
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> fetchProductById(int id) async {
    _isLoading = true;
    _errorMessage = null;
    _selectedProduct = null; // Kosongkan dulu data lama
    notifyListeners();

    try {
      _selectedProduct = await _supabaseService.getProductById(id);
      print("DEBUG (ViewModel): Hasil dari service adalah -> $_selectedProduct");
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

   
}