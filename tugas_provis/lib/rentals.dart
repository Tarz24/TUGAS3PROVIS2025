import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RentalPage(),
    );
  }
}

class RentalPage extends StatelessWidget {
  final List<RentalItem> items = [
    RentalItem(
      image: 'assets/tenda.png',
      title: 'Tenda Camping Consina',
      duration: '3 days',
      durationColor: Colors.green,
    ),
    RentalItem(
      image: 'assets/sleepingbag.png',
      title: 'Sleepingbag Polar\nTebal + Bantal',
      duration: '2 days',
      durationColor: Colors.orange,
    ),
    RentalItem(
      image: 'assets/sepatu.png',
      title: 'Sepatu Outdoor OWEN',
      duration: '6 Hours',
      durationColor: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Center(child: Icon(Icons.shopping_bag_outlined)),
        actions: [Icon(Icons.menu)],
        backgroundColor: Color(0xFF083C63),
      ),
      body: Container(
        color: Color(0xFFFFF5D1),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Your Rentals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return RentalCard(item: items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RentalItem {
  final String image;
  final String title;
  final String duration;
  final Color durationColor;

  RentalItem({
    required this.image,
    required this.title,
    required this.duration,
    required this.durationColor,
  });
}

class RentalCard extends StatelessWidget {
  final RentalItem item;

  const RentalCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                item.image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: item.durationColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.duration,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
