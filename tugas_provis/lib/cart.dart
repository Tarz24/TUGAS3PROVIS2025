import 'package:flutter/material.dart';
import 'package:tugas_provis/checkout.dart';
import 'package:tugas_provis/supabase_client.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  // Variabel Future untuk menampung data keranjang dari Supabase
  late Future<List<Map<String, dynamic>>> _cartFuture;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  // Fungsi untuk mengambil data keranjang
  void _loadCartItems() {
    _cartFuture = supabase
        .from('cart_items')
        .select('*, products(*)') // Ambil data dari cart_items DAN produk terkait
        .eq('user_id', supabase.auth.currentUser!.id);
  }

  // Fungsi untuk menghapus item dan memuat ulang data
  Future<void> _deleteItem(int cartItemId) async {
    try {
      await supabase.from('cart_items').delete().eq('id', cartItemId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Item berhasil dihapus dari keranjang.'),
          backgroundColor: Colors.green,
        ));
        // Muat ulang data keranjang setelah menghapus
        setState(() {
          _loadCartItems();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal menghapus item: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3CB),
      body: Column(
        children: [
          // Header (Kode UI Anda)
          Container(
            padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 8, 16, 16),
            color: const Color(0xFF103B68),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Icon(Icons.shopping_cart, color: Colors.white, size: 32),
                const Icon(Icons.menu, color: Colors.transparent), // Placeholder
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _cartFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final cartItems = snapshot.data!;

                if (cartItems.isEmpty) {
                  return const Center(
                    child: Text(
                      'Keranjang Anda masih kosong.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                // Hitung total harga
                double totalPrice = 0;
                for (var item in cartItems) {
                  final product = item['products'];
                  if (product != null) {
                    totalPrice += (product['price_per_day'] as num) * (item['quantity'] as int);
                  }
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          // Data produk ada di dalam 'products' karena join
                          final product = cartItem['products'];

                          if (product == null) {
                            return const ListTile(title: Text('Data produk tidak valid.'));
                          }

                          // Menggunakan kembali struktur dari cart_item.dart
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      product['image_url'] ?? 'https://placehold.co/100x100/png?text=No+Image',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(product['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                          Text("Jumlah: ${cartItem['quantity']}"),
                                          Text("IDR ${product['price_per_day']}/day", style: const TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                                      onPressed: () => _deleteItem(cartItem['id']),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => CheckoutPage(product: product)
                                        ));
                                      },
                                      child: const Text('Checkout'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Bottom Bar dengan Total Harga
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF103B68),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Harga Keranjang:\nIDR $totalPrice",
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          // Tombol checkout semua bisa ditambahkan di sini jika perlu
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

