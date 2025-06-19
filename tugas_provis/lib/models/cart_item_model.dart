// lib/models/cart_item_model.dart

import 'package:tugas_provis/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    this.quantity = 1,
  });
}