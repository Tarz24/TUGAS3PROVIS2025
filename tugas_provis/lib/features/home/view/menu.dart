import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import yang disesuaikan dengan struktur baru
import 'package:tugas_provis/features/home/widgets/product_card.dart';
import 'package:tugas_provis/viewmodels/product_viewmodel.dart';
import 'package:tugas_provis/models/product_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool showSidebar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
  
  return Scaffold(
    backgroundColor: const Color(0xFFFDF2D0),
    body: SafeArea(
        child: Stack(
          children: [
            // === Konten utama ===
            Column(
              children: [
                buildHeader(),
                buildSearchBar(productViewModel), // Kirim viewModel ke search bar
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Well hello, there',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  // Tampilkan loading atau list produk
                  child: productViewModel.isSearching
                      ? const Center(child: CircularProgressIndicator())
                      : buildProductList(productViewModel),
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
            if (showSidebar) buildSidebar(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    // Header
    return Container(
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
    );
  }

Widget buildSearchBar(ProductViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(100, 13, 59, 102),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                border: InputBorder.none,
                // Tambahkan tombol 'clear' jika ada teks
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white),
                        onPressed: () {
                          _searchController.clear();
                          viewModel.clearSearch(); // Bersihkan hasil pencarian di ViewModel
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                // Update UI tombol clear saat mengetik
                setState(() {});
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 30),
            onPressed: () {
              // Panggil fungsi search di ViewModel
              viewModel.performSearch(_searchController.text.trim());
              // Tutup keyboard
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }

  // Menampilkan daftar produk atau hasil pencarian
  Widget buildProductList(ProductViewModel viewModel) {
    // Tentukan list mana yang akan ditampilkan
    final bool isSearching = viewModel.searchResults.isNotEmpty || (_searchController.text.isNotEmpty && !viewModel.isSearching);
    final List<ProductModel> productsToShow = isSearching ? viewModel.searchResults : viewModel.products;

    if (viewModel.isLoading && !isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null) {
      return Center(child: Text('Terjadi error: ${viewModel.errorMessage}'));
    }

    if (productsToShow.isEmpty) {
      return Center(
          child: Text(isSearching
              ? 'Produk tidak ditemukan.'
              : 'Belum ada produk yang tersedia.'));
    }

    return ListView.builder(
      itemCount: productsToShow.length,
      itemBuilder: (context, index) {
        final product = productsToShow[index];
        return ProductCard(product: product);
      },
    );
  }

   Widget buildSidebar() {
    return Align(
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
              onPressed: () {
                // Navigasi ke halaman profil
                Navigator.pushNamed(context, '/profile');
              },
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
    );
  }
}