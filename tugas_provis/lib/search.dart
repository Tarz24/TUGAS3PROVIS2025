import 'package:flutter/material.dart';
import 'package:tugas_provis/checkout.dart';
import 'package:tugas_provis/produk.dart';
import 'package:tugas_provis/supabase_client.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  // Fungsi untuk melakukan pencarian ke Supabase
  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Menggunakan 'ilike' untuk case-insensitive search
      // %query% berarti mencari produk yang namanya mengandung kata kunci
      final data = await supabase
          .from('products')
          .select()
          .ilike('name', '%$query%');
      
      setState(() {
        _searchResults = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error saat mencari: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Search TextField di dalam AppBar
        title: TextField(
          controller: _searchController,
          autofocus: true, // Otomatis fokus saat halaman dibuka
          decoration: const InputDecoration(
            hintText: 'Cari produk...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70)
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
          onChanged: _performSearch, // Mencari setiap kali teks berubah
        ),
        backgroundColor: const Color(0xFF0D3B66),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFFDF2D0),
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchController.text.isNotEmpty && _searchResults.isEmpty) {
      return const Center(
        child: Text('Produk tidak ditemukan.', style: TextStyle(fontSize: 18)),
      );
    }
    
    // Tampilkan hasil pencarian
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        // Kita gunakan kembali UI Card dari halaman menu
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(productId: product['id']),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: // ... (Struktur UI card yang sama persis seperti di menu.dart)
              Column(
                children: [
                   Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(product[
                                      'image_url'] ??
                                  'https://placehold.co/100x100/png?text=No+Image'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'].toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "IDR ${product['price_per_day']}/day",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color:
                                        Colors.deepOrange),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.blue),
                          tooltip: 'Tambah ke Keranjang',
                          onPressed: () async {
                              try {
                                await supabase
                                    .from('cart_items')
                                    .insert({
                                  'user_id': supabase
                                      .auth.currentUser!.id,
                                  'product_id': product['id'],
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      '${product['name']} ditambahkan ke keranjang.'),
                                  backgroundColor:
                                      Colors.green,
                                ));
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Gagal menambahkan ke keranjang. Mungkin sudah ada?'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                          },
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CheckoutPage(
                                          product: product),
                                ),
                              );
                          },
                          child: const Text("Sewa"),
                        ),
                      ],
                    )
                ],
              )
            ),
          ),
        );
      },
    );
  }
}

