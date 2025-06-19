import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas_provis/supabase_client.dart';

// FIX: Mengubah class agar bisa menerima data produk (Map), BUKAN Future
class CheckoutPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const CheckoutPage({super.key, required this.product});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int quantity = 1;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 1));

  Future<void> _selectDate(BuildContext context, {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate : endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate.isBefore(startDate)) {
            endDate = startDate.add(const Duration(days: 1));
          }
        } else {
          // Tanggal kembali tidak boleh sebelum tanggal mulai
          if (picked.isAfter(startDate) || picked.isAtSameMomentAs(startDate)){
            endDate = picked;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Tanggal kembali tidak boleh sebelum tanggal mulai.'),
              backgroundColor: Colors.red,
            ));
          }
        }
      });
    }
  }

  int get rentalDays {
    final difference = endDate.difference(startDate).inDays;
    return difference < 1 ? 1 : difference; // Minimal sewa 1 hari
  }

  @override
  Widget build(BuildContext context) {
    // FIX: HAPUS FutureBuilder, kita sudah punya datanya
    final productData = widget.product;
    final pricePerDay = (productData['price_per_day'] as num).toDouble();
    final totalPrice = pricePerDay * quantity * rentalDays;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF4CD),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: const Color(0xFF15406A),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text("Check Out", style: TextStyle(color: Colors.white, fontSize: 20)),
                  // Anda bisa menambahkan ikon lain di sini jika perlu
                  const SizedBox(width: 48)
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Product Info Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                productData['image_url'] ??
                                    'https://placehold.co/80x80/png?text=No+Image',
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  productData['name'].toString(),
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                "IDR ${productData['price_per_day']}/day",
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Jumlah:", style: TextStyle(fontSize: 16)),
                              _itemCounter(productData['quantity_available']),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _sectionContainer(
                      title: "Tanggal Penyewaan",
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text("Tanggal Mulai"),
                            subtitle: Text("${startDate.toLocal()}".split(' ')[0]),
                            trailing: const Icon(Icons.calendar_today),
                            onTap: () => _selectDate(context, isStartDate: true),
                          ),
                          ListTile(
                            title: const Text("Tanggal Kembali"),
                            subtitle: Text("${endDate.toLocal()}".split(' ')[0]),
                            trailing: const Icon(Icons.calendar_today),
                            onTap: () => _selectDate(context, isStartDate: false),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Total Durasi: $rentalDays hari",
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF4A6880),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total", style: TextStyle(color: Colors.white70, fontSize: 16)),
                      Text("IDR $totalPrice", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await supabase.from('rentals').insert({
                          'user_id': supabase.auth.currentUser!.id,
                          'product_id': productData['id'],
                          'quantity': quantity,
                          'start_date': startDate.toIso8601String(),
                          'end_date': endDate.toIso8601String(),
                          'total_price': totalPrice,
                          'status': 'pending'
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Penyewaan berhasil dibuat!'),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Gagal membuat penyewaan: $e'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Proceed", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemCounter(int maxQuantity) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A6880),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.white),
            onPressed: () {
              if (quantity > 1) setState(() => quantity--);
            },
          ),
          Text("$quantity", style: const TextStyle(color: Colors.white, fontSize: 16)),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              if (quantity < maxQuantity) {
                setState(() => quantity++);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Stok tidak mencukupi. Maks: $maxQuantity'),
                  backgroundColor: Colors.orange,
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionContainer({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title :", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          child
        ],
      ),
    );
  }
}
