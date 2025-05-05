import 'package:flutter/material.dart';

class LaporanMasalahPage extends StatelessWidget {
  const LaporanMasalahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8D7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F497B),
        centerTitle: true,
        title: const Text('Laporan Masalah', style: TextStyle(color: Colors.white)),
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
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Langkah-langkah:\n\n1. Jelaskan masalah secara rinci.\n2. Sertakan screenshot jika memungkinkan.\n3. Kirim melalui formulir berikut.'),
            const SizedBox(height: 24),
            _buildTextField('Judul Masalah'),
            _buildTextField('Deskripsi', maxLines: 5),
            const SizedBox(height: 16),
            const Text('Unggah Gambar (opsional)'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Choose File'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F497B)),
              child: const Text('Kirim Laporan', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
