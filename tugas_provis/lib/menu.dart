// lib/menu.dart

import 'package:flutter/material.dart';
import 'package:tugas_provis/supabase_client.dart';
// Import halaman yang akan kita tuju
import 'package:tugas_provis/produk.dart';
import 'package:tugas_provis/checkout.dart';
import 'package:tugas_provis/cart.dart'; // Import halaman keranjang
class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool showSidebar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2D0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // === Konten utama ===
              Column(
                children: [
                  // Header (Kode Anda, tidak diubah)
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
                    color: const Color(0xFF0D3B66),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/logofull.png',
                          width: 280,
                        ),
                        const Spacer(),
                        TextButton(
                          child: const Image(
                            image: AssetImage('assets/images/III.png'),
                            height: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              showSidebar = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Search bar (Kode Anda, tidak diubah)
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(100, 13, 59, 102),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/images/searchicon.png'),
                          height: 50,
                        ),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Well hello, there',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),

                  // === BAGIAN YANG DIMODIFIKASI ===
                  // Mengganti daftar produk dengan FutureBuilder yang interaktif
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: supabase.from('products').select(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Tidak ada produk tersedia.'));
                      }

                      final products = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          // Widget Kartu Produk Interaktif
                          return GestureDetector(
                            // AKSI 1: Menekan seluruh kartu akan ke halaman detail
                            onTap: () {
                              print(
                                  'Navigasi ke detail produk ID: ${product['id']}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductPage(productId: product['id']),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    // Bagian Atas: Gambar dan Info Produk
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
                                    // Bagian Bawah: Tombol Aksi
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Tombol Add to Cart
                                        IconButton(
                                          icon: const Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.blue),
                                          tooltip: 'Tambah ke Keranjang',
                                          onPressed: () async {
                                            // AKSI 2: Tambah ke Keranjang
                                            print(
                                                'Menambahkan produk ID: ${product['id']} ke keranjang');
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
                                        // Tombol Sewa Sekarang
                                        ElevatedButton(
                                          onPressed: () {
                                            // AKSI 3: Langsung ke Halaman Checkout
                                            print(
                                                'Checkout produk ID: ${product['id']}');
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  // === AKHIR BAGIAN YANG DIMODIFIKASI ===

                  // Chat box (Kode Anda, tidak diubah)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3F6A89),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.chat_bubble_outline, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Baru pertama kali berkemah?\nbisa konsultasi dengan kami dulu lhoo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Sidebar Kanan (Kode Anda, tidak diubah)
              if (showSidebar)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 80,
                    height: MediaQuery.of(context).size.height * 0.55,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5D7581),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(-2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon:
                                const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                showSidebar = false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          icon: const Icon(Icons.person, color: Colors.white),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          icon: const Icon(Icons.shopping_cart,
                              color: Colors.white),
                          onPressed: () {
                            // Navigasi ke halaman KeranjangPage saat ditekan
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const KeranjangPage()),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          icon: const Icon(Icons.shopping_bag,
                              color: Colors.white),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          icon: const Icon(Icons.chat, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
