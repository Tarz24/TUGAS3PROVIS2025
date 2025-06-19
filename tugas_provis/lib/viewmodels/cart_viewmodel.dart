// lib/viewmodels/cart_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:tugas_provis/models/cart_item_model.dart';
import 'package:tugas_provis/services/supabase_services.dart';

class CartViewModel extends ChangeNotifier {
  final _supabaseService = SupabaseService();

  List<CartItemModel> _cartItems = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CartItemModel> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += (item.product?.pricePerDay ?? 0) * item.quantity;
    }
    return total;
  }

  Future<void> fetchCartItems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _cartItems = await _supabaseService.getCartItems();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart({required int productId, int quantity = 1}) async {
    try {
      await _supabaseService.addToCart(productId: productId, quantity: quantity);
      // Setelah berhasil, ambil ulang data keranjang untuk refresh UI
      await fetchCartItems();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}