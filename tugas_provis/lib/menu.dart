// lib/menu.dart

// TAMBAHKAN IMPORT untuk halaman search yang akan kita buat
import 'package:tugas_provis/search.dart'; 
import 'package:flutter/material.dart';
import 'package:tugas_provis/cart.dart';
import 'package:tugas_provis/checkout.dart';
import 'package:tugas_provis/produk.dart';
import 'package:tugas_provis/profile.dart';
import 'package:tugas_provis/rentals.dart';
import 'package:tugas_provis/supabase_client.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool showSidebar = false;

  // ===== FUNGSI BARU UNTUK MEMBUKA WHATSAPP =====
  Future<void> _launchWhatsAppChat() async {
    // Ganti nomor telepon ini dengan nomor WhatsApp admin/toko Anda
    // Gunakan format internasional tanpa spasi, tanda kurung, atau '+'
    const String phoneNumber = '6285775712437'; // Contoh: 62 untuk Indonesia
    
    // Pesan default yang akan muncul di WhatsApp
    const String message = 'Halo, saya tertarik untuk menyewa peralatan kemah dari CAMPRENT.';
    
    // Buat URL WhatsApp
    final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

    // Coba buka URL
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Tampilkan error jika gagal membuka WhatsApp
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka WhatsApp. Pastikan aplikasi sudah terinstal.')),
        );
      }
    }
  }
  Future<void> _launchWhatsAppKonsul() async {
    // Ganti nomor telepon ini dengan nomor WhatsApp admin/toko Anda
    // Gunakan format internasional tanpa spasi, tanda kurung, atau '+'
    const String phoneNumber = '6285775712437'; // Contoh: 62 untuk Indonesia
    
    // Pesan default yang akan muncul di WhatsApp
    const String message = 'Halo, saya ingin berkonsultasi tentang penyewaan peralatan kemah.';

    // Buat URL WhatsApp
    final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

    // Coba buka URL
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Tampilkan error jika gagal membuka WhatsApp
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka WhatsApp. Pastikan aplikasi sudah terinstal.')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2D0),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header...
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

                // ===== PERUBAHAN DI SINI =====
                // Bungkus Container search bar dengan GestureDetector
                GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman SearchPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchPage()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15), // Padding disesuaikan
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(100, 13, 59, 102),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.white70),
                        const SizedBox(width: 10),
                        const Text(
                          'Cari peralatan kemah...', // Tambahkan placeholder text
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                // ===== AKHIR PERUBAHAN =====

                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Well hello, there',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                
                // Daftar produk dinamis Anda...
                // (Kode FutureBuilder Anda di sini, tidak perlu diubah)
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
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
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
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
                ),
                  // Chat box...
                GestureDetector(
                  onTap: _launchWhatsAppKonsul, // Panggil fungsi yang sama dengan tombol di sidebar
                  child: Container(
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
                            'Baru pertama kali berkemah?\nBisa konsultasi dengan kami dulu lho!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Sidebar...
            // === Sidebar Kanan dengan tombol X ===
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfilePage()),
                          );
                        },
                        tooltip: 'Profil',
                      ),
                      const SizedBox(height: 20),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart,
                            color: Colors.white),
                        onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const KeranjangPage()),
                          );
                        },
                        tooltip: 'Keranjang',
                      ),
                      const SizedBox(height: 20),
                      IconButton(
                        icon: const Icon(Icons.shopping_bag,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RentalPage()),
                          );
                        },
                        tooltip: 'Barang Sewaan Saya',
                      ),
                      const SizedBox(height: 20),
                      // ===== PERUBAHAN DI SINI =====
                      IconButton(
                        icon: const Icon(Icons.chat, color: Colors.white),
                        onPressed: _launchWhatsAppChat, // Panggil fungsi WhatsApp
                        tooltip: 'Hubungi Admin via WhatsApp',
                      ),
                      // ===== AKHIR PERUBAHAN =====
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
