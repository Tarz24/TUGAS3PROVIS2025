import 'package:flutter/material.dart';
import 'package:tugas_provis/checkout.dart';
import 'package:tugas_provis/supabase_client.dart';

// Mengubah class agar bisa menerima productId dari halaman menu
class ProductPage extends StatefulWidget {
  final int productId;
  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Future untuk mengambil data satu produk
  late final Future<Map<String, dynamic>> _productFuture;

  @override
  void initState() {
    super.initState();
    // Ambil detail produk berdasarkan ID yang diterima
    _productFuture = supabase
        .from('products')
        .select()
        .eq('id', widget.productId)
        .single();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold sekarang berada di dalam FutureBuilder agar FAB bisa mengakses data 'product'
    return FutureBuilder<Map<String, dynamic>>(
      future: _productFuture,
      builder: (context, snapshot) {
        // Tampilkan loading screen jika data belum siap
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        // Tampilkan error jika terjadi masalah
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
              body: Center(
                  child: Text(
                      'Error: ${snapshot.error ?? "Produk tidak ditemukan."}')));
        }

        final product = snapshot.data!;

        // Tampilkan UI Halaman Produk dengan data dinamis
        return Scaffold(
          backgroundColor: const Color(0xFFFFF7D4),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          product['image_url'] ??
                              'https://placehold.co/600x400/png?text=No+Image',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 350,
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                                ? child
                                : const Center(child: CircularProgressIndicator());
                          },
                        ),
                        Positioned(
                          top: 40,
                          left: 16,
                          child: CircleAvatar(
                            backgroundColor:
                            Colors.blue.shade900.withOpacity(0.7),
                            child: IconButton(
                              icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: (product['tags'] as List<dynamic>? ?? [])
                            .map((tag) => BadgeLabel(label: tag.toString()))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        product['name'].toString(),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        product['description'] ??
                            'Tidak ada deskripsi untuk produk ini.',
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // FIX: Kirim data 'product' yang sudah jadi (Map), bukan '_productFuture'
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(product: product),
                ),
              );
            },
            backgroundColor: Colors.blue.shade900,
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
            label: const Text("Sewa Sekarang", style: TextStyle(color: Colors.white)),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

// Widget BadgeLabel tidak diubah
class BadgeLabel extends StatelessWidget {
  final String label;
  const BadgeLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    if (label.toLowerCase() == 'hot deal') {
      badgeColor = Colors.orange;
    } else if (label.toLowerCase() == 'recommended') {
      badgeColor = Colors.green;
    } else {
      badgeColor = Colors.blueGrey;
    }
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
