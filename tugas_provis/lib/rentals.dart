import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Package untuk format tanggal
import 'package:tugas_provis/supabase_client.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  late Future<List<Map<String, dynamic>>> _rentalsFuture;

  @override
  void initState() {
    super.initState();
    _loadRentals();
  }

  // Fungsi untuk mengambil data dari tabel 'rentals'
  void _loadRentals() {
    _rentalsFuture = supabase
        .from('rentals')
        .select('*, products(*)') // Ambil data rental DAN produk terkait
        .eq('user_id', supabase.auth.currentUser!.id)
        .order('created_at', ascending: false); // Urutkan dari yang terbaru
  }

  // Fungsi untuk mendapatkan warna status
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Riwayat Penyewaan', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF083C63),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFFF5D1),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _rentalsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final rentals = snapshot.data!;

            if (rentals.isEmpty) {
              return const Center(
                child: Text('Anda belum pernah menyewa barang.',
                    style: TextStyle(fontSize: 18)),
              );
            }

            return ListView.builder(
              itemCount: rentals.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final rental = rentals[index];
                final product = rental['products'];
                
                // Format tanggal agar lebih mudah dibaca
                final startDate = DateFormat('d MMM yyyy').format(DateTime.parse(rental['start_date']));
                final endDate = DateFormat('d MMM yyyy').format(DateTime.parse(rental['end_date']));

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            product?['image_url'] ?? 'https://placehold.co/70x70/png?text=N/A',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product?['name'] ?? 'Produk tidak ditemukan',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text('Sewa: $startDate - $endDate'),
                              Text('Jumlah: ${rental['quantity']}'),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(rental['status']),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            rental['status']?.toString().toUpperCase() ?? 'N/A',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
