import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final bool showPeople;

  const CartItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    this.showPeople = false,
  });

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 66),
                  Text(
                    price,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (showPeople)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A6880),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "2 Orang",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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