import 'package:flutter/material.dart';
// Import yang disesuaikan dengan struktur baru
import '../widgets/cart_item.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3CB),
      body: Column(
        children: [
          _header(),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: const [
                CartItem(
                  imagePath: 'assets/images/tenda.jpg',
                  title: 'Tenda Camping Consina',
                  price: 'IDR 120.000/day',
                  showPeople: true,
                ),
                CartItem(
                  imagePath: 'assets/images/sleeping_bag.jpg',
                  title: 'Sleepingbag Polar Tebal + Bantal',
                  price: 'IDR 25.000/day',
                ),
                CartItem(
                  imagePath: 'assets/images/sepatu.jpg',
                  title: 'Sepatu Outdoor OWEN',
                  price: 'IDR 45.000/day',
                ),
              ],
            ),
          ),
          _bottomBar(),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF103B68),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.arrow_back_ios, color: Colors.white),
          Icon(Icons.shopping_cart, color: Colors.white, size: 32),
          Icon(Icons.menu, color: Colors.white),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF103B68),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text("Checkout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}