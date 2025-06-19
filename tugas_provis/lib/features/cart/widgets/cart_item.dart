import 'package:flutter/material.dart';
import 'package:tugas_provis/models/cart_item_model.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    // Jika data produk tidak ada (seharusnya tidak terjadi jika JOIN berhasil)
    if (cartItem.product == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  cartItem.product!.imageUrl ?? 'URL_PLACEHOLDER',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(cartItem.product!.name ?? 'Nama Produk', style: const TextStyle(fontSize: 22)),
              ),
              Column(
                children: [
                  const SizedBox(height: 66),
                  Text(
                    "IDR ${cartItem.product!.pricePerDay?.toStringAsFixed(0) ?? '0'}/day",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 20),
              _counter(),
              const SizedBox(width:  8),
              _counter(isDay: true),
              const SizedBox(width:  8),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.calendar_month, color: Colors.white),
                style: IconButton.styleFrom(
                  backgroundColor: Color(0xFF103B68),
                  shape: const CircleBorder(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _counter({bool isDay = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A6880),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove, color: Colors.white),
          ),
          Text(
            "1${isDay ? ' day' : ''}",
            style: const TextStyle(color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}