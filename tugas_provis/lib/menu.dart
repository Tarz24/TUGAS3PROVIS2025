// Tambahan di bagian atas tetap sama
import 'package:flutter/material.dart';
import 'package:tugas_provis/supabase_client.dart';
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
                  // Header
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 8, 0, 8),
                    color: const Color(0xFF0D3B66),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/logofull.png',
                          width: 280,
                        ),
                        const Spacer(),
                        TextButton(
                          child: Image(
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

                  // Search bar
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color:Color.fromARGB(100, 13, 59, 102),
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

                  // Produk 1
                 // Letakkan FutureBuilder ini di dalam Column, setelah "Well hello, there" Text
                  FutureBuilder<List<Map<String, dynamic>>>(
                    // Ambil semua data dari tabel 'products'
                    future: supabase.from('products').select(),
                    builder: (context, snapshot) {
                      // Tampilkan ikon loading jika data sedang diambil
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // Tampilkan pesan jika tidak ada data
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Tidak ada produk tersedia.'));
                      }

                      // Jika data ada, simpan ke dalam variabel
                      final products = snapshot.data!;

                      // Gunakan ListView.builder untuk menampilkan setiap produk
                      return ListView.builder(
                        shrinkWrap: true, // Wajib di dalam SingleChildScrollView
                        physics: const NeverScrollableScrollPhysics(), // Wajib di dalam SingleChildScrollView
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          // Di sini kita gunakan kembali struktur UI Anda yang sudah ada,
                          // tetapi dengan data dinamis dari 'product'.
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        // GANTI dari AssetImage menjadi NetworkImage
                                        image: NetworkImage(product['image_url'] ?? 'URL_GAMBAR_DEFAULT_JIKA_NULL'),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(color: Colors.black, style: BorderStyle.solid),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 4.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // ... Anda bisa menambahkan logika untuk 'tags' di sini jika mau
                                          const SizedBox(height: 3),
                                          Text(
                                            // GANTI teks statis dengan nama produk dari database
                                            product['name'].toString(),
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(height: 30),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                // GANTI harga statis dengan harga dari database
                                                "IDR ${product['price_per_day']}/day",
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),


                  // Chat box
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

              // === Sidebar Kanan dengan tombol X ===
              if (showSidebar)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 80,
                    height: MediaQuery.of(context).size.height * 0.55, // setengah atas
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
                            icon: const Icon(Icons.close, color: Colors.white),
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
                          icon: const Icon(Icons.shopping_cart, color: Colors.white),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          icon: const Icon(Icons.shopping_bag, color: Colors.white),
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
