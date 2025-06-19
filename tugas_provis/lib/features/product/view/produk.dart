import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_provis/viewmodels/product_viewmodel.dart';
import 'package:tugas_provis/viewmodels/cart_viewmodel.dart';

class ProductPage extends StatefulWidget {

  const ProductPage({Key? key}) : super(key: key); // Ubah konstruktor

  @override
  State<ProductPage> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductPage> {
  String selectedVariant = "2 Orang";
  
  @override
  void initState() {
    super.initState();
    // Panggil ViewModel untuk mengambil data saat halaman pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 1. Ambil argumen dengan aman
      final arguments = ModalRoute.of(context)?.settings.arguments;

      // 2. Lakukan pengecekan tipe data sebelum digunakan
      if (arguments is int) {
        final int productId = arguments; // Sekarang kita punya ID yang aman
        
        // 3. Panggil ViewModel untuk mengambil data
        context.read<ProductViewModel>().fetchProductById(productId);
      } else {
        // Handle jika argumen tidak dikirim atau tipenya salah
        print("Error: Argumen productId tidak ditemukan atau tipe datanya salah.");
        // Anda bisa mengatur pesan error di ViewModel di sini jika perlu
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    

    final viewModel = context.watch<ProductViewModel>();
    // Tampilkan loading indicator jika sedang fetching
    if (viewModel.isLoading && viewModel.selectedProduct == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Tampilkan pesan error jika terjadi kegagalan
    if (viewModel.errorMessage != null) {
      return Center(child: Text('Error: ${viewModel.errorMessage}'));
    }

    // Tampilkan pesan jika produk tidak ditemukan
    if (viewModel.selectedProduct == null) {
      return const Center(child: Text('Produk tidak ditemukan.'));
    }
    
    final product = viewModel.selectedProduct!;

    return Scaffold(
      backgroundColor: Color(0xFFFFF7D4),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      product.imageUrl ?? 'https://via.placeholder.com/400',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 350,
                    ),
                    Positioned(
                      top: 30,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.shade900,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Wrap( // Gunakan Wrap agar rapi jika tags banyak
                    spacing: 8.0,
                    children: product.tags.map((tag) => BadgeLabel(label: tag, color: _getColorForTag(tag))).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.name ?? 'Nama Produk',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.description ?? 'Tidak ada deskripsi.',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Varian:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: (product.variants?.keys ?? []).map((variantName) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: VariantButton(
                          label: variantName,
                          isSelected: selectedVariant == variantName,
                          onTap: () {
                            setState(() {
                              selectedVariant = variantName;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          // Dapatkan product yang sedang ditampilkan
          final product = context.read<ProductViewModel>().selectedProduct;

          if (product != null) {
            // Panggil fungsi addToCart dari CartViewModel
            context.read<CartViewModel>().addToCart(productId: product.id);
            
            // Tampilkan notifikasi
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} ditambahkan ke keranjang!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}

class BadgeLabel extends StatelessWidget {
  final String label;
  final Color color;

  const BadgeLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class VariantButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const VariantButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue.shade900 : Colors.blueGrey.shade600,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: isSelected ? 4 : 2,
      ),
    );
  }
}

// Fungsi helper diletakkan di dalam class State yang sama
Color _getColorForTag(String tag) {
  switch (tag.toLowerCase()) {
    case 'hot deal':
      return Colors.orange;
    case 'recommended':
      return Colors.green;
    default:
      return Colors.grey.shade600;
  }
}
