import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {'q': 'Bagaimana cara mulai menggunakan aplikasi ini?', 'a': 'Daftar akun terlebih dahulu, lalu login untuk mengakses semua fitur.'},
      {'q': 'Bisa dipakai di lebih dari satu perangkat?', 'a': 'Bisa! Cukup login dengan akun yang sama di perangkat lain.'},
      {'q': 'Bisa dipakai di lebih dari satu perangkat?', 'a': 'Bisa! Cukup login dengan akun yang sama di perangkat lain.'},
      {'q': 'Ada fitur dark mode?', 'a': 'Saat ini belum tersedia, tapi kami sedang mengembangkannya!'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8D7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F497B),
        centerTitle: true,
        title: const Text('FAQ', style: TextStyle(color: Colors.white)),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Q: ${faqs[index]['q']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('A: ${faqs[index]['a']}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
