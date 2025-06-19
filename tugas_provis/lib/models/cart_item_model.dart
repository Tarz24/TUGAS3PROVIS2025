import 'product_model.dart';

class CartItemModel {
  final int id;
  final String userId;
  final int productId;
  int quantity;
  final DateTime createdAt;
  final ProductModel? product; // Untuk menampung data produk dari JOIN

  CartItemModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      productId: json['product_id'] as int,
      quantity: json['quantity'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      product: json['products'] != null
          ? ProductModel.fromJson(json['products'])
          : null,
    );
  }
}