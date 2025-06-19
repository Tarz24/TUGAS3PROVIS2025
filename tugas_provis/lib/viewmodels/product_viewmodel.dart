import 'package:flutter/foundation.dart';
import 'package:tugas_provis/models/product_model.dart';
import 'package:tugas_provis/services/supabase_services.dart';

class ProductViewModel extends ChangeNotifier {
  final _supabaseService = SupabaseService();

  bool _isLoading = true; // Langsung true saat pertama kali dibuat
  List<ProductModel> _products = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<ProductModel> get products => _products;
  String? get errorMessage => _errorMessage;

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

  Future<void> fetchProductById(int id) async {
    _isLoading = true;
    _errorMessage = null;
    _selectedProduct = null; // Kosongkan dulu data lama
    notifyListeners();

    try {
      _selectedProduct = await _supabaseService.getProductById(id);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}