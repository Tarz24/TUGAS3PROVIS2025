import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_provis/viewmodels/cart_viewmodel.dart';
import '../widgets/cart_item.dart'; // Pastikan path ini benar

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  void initState() {
    super.initState();
    // Ambil data keranjang saat halaman pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartViewModel>().fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF3CB),
      body: Column(
        children: [
          _header(),
          const SizedBox(height: 12),
          Expanded(
            child: _buildCartList(cartViewModel),
          ),
          // Tampilkan total dan tombol checkout hanya jika ada item
          if (cartViewModel.cartItems.isNotEmpty)
            _bottomBar(cartViewModel.totalPrice),
        ],
      ),
    );
  }

  Widget _buildCartList(CartViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.errorMessage != null) {
      return Center(child: Text('Error: ${viewModel.errorMessage}'));
    }
    if (viewModel.cartItems.isEmpty) {
      return const Center(child: Text('Keranjang Anda masih kosong.'));
    }

    return ListView.builder(
      itemCount: viewModel.cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = viewModel.cartItems[index];
        // Kita akan modifikasi CartItem widget agar menerima CartItemModel
        return CartItem(cartItem: cartItem);
      },
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF103B68),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.arrow_back_ios, color: Colors.white),
          Icon(Icons.shopping_cart, color: Colors.white, size: 32),
          Icon(Icons.menu, color: Colors.white),
        ],
      ),
    );
  }

  Widget _bottomBar(double totalPrice) {
    return Container(
      // ... (kode styling _bottomBar tetap sama)
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total\nIDR ${totalPrice.toStringAsFixed(0)}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          ElevatedButton(
            onPressed: () { /* Navigasi ke CheckoutPage */ },
            // ... (kode styling tombol tetap sama)
            child: const Text("Checkout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}