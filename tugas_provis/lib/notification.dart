import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8D7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F497B),
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white, // <-- Ubah jadi putih
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Mei 2025',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _notificationItem('Pengembalian Barang',
              'Jangan lupa untuk mengembalikan barang barangnya pada waktu yang telah ditentukan.'),
          _notificationItem('Checkout Keranjang',
              'Jangan lupa untuk meng-checkout pesanamu.'),
          const SizedBox(height: 24),
          const Text(
            'April 2025',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _notificationItem('Penggunaan Aplikasi',
              'Jika anda tidak mengerti atau bingung bisa tanyakan pada kami dikolom chat.'),
          _notificationItem('Selamat Datang di CAMPRENT',
              'Terimakasih telah daftar di aplikasi CAMPRENT ini dan semoga kami bisa memberikan pelayanan yang baik.'),
        ],
      ),
    );
  }

  static Widget _notificationItem(String title, String desc) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.circle, size: 12, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
