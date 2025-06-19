// lib/viewmodels/cart_viewmodel.dart

import 'package:flutter/foundation.dart';
import 'package:tugas_provis/models/cart_item_model.dart';
import 'package:tugas_provis/models/product_model.dart';

class CartViewModel extends ChangeNotifier {
  // Daftar item di dalam keranjang
  final List<CartItemModel> _items = [];

  // Getter untuk mengakses daftar item dari luar
  List<CartItemModel> get items => _items;

  // Getter untuk menghitung total harga
  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      total += (item.product.pricePerDay ?? 0) * item.quantity;
    }
    return total;
  }

  // Fungsi untuk menambahkan produk ke keranjang
  void addToCart(ProductModel product) {
    // Cek apakah produk sudah ada di keranjang
    for (var item in _items) {
      if (item.product.id == product.id) {
        // Jika sudah ada, cukup tambah kuantitasnya
        item.quantity++;
        notifyListeners(); // Beri tahu UI untuk update
        return;
      }
    }

    // Jika belum ada, tambahkan sebagai item baru
    _items.add(CartItemModel(product: product));
    notifyListeners(); // Beri tahu UI untuk update
  }

  // Fungsi untuk menambah kuantitas item
  void incrementQuantity(CartItemModel cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  // Fungsi untuk mengurangi kuantitas item
  void decrementQuantity(CartItemModel cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      // Jika kuantitas tinggal 1 dan dikurangi, hapus item dari keranjang
      _items.remove(cartItem);
    }
    notifyListeners();
  }

  // Fungsi untuk menghapus item dari keranjang (opsional, bisa untuk tombol hapus)
  void removeFromCart(CartItemModel cartItem) {
    _items.remove(cartItem);
    notifyListeners();
  }
}