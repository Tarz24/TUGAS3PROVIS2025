import 'package:flutter/material.dart';
import 'package:tugas_provis/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bungkus semua dengan InkWell untuk membuatnya bisa diklik
    return InkWell(
      onTap: () {
        // Logika saat kartu diklik
        print('Produk dengan ID ${product.id} diklik.');
        
        // Pergi ke halaman detail dan kirim 'id' produk sebagai argumen
        Navigator.pushNamed(
          context,
          '/product-detail', // Nama rute yang akan kita buat
          arguments: product.id, // Mengirim ID produk
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gunakan NetworkImage untuk memuat gambar dari URL
            Container(
              padding: EdgeInsets.all(4.0),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  // Jika imageUrl null, tampilkan gambar placeholder
                  image: NetworkImage(product.imageUrl ?? 'https://via.placeholder.com/100'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.black, style: BorderStyle.solid),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Anda bisa menambahkan logika untuk menampilkan tags di sini
                  // jika 'product.tags' tidak kosong
                  if (product.tags.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Wrap( // Gunakan Wrap agar rapi jika tags banyak
                            spacing: 8.0,
                            children: product.tags.map((tag) => BadgeLabel(label: tag, color: _getColorForTag(tag))).toList(),
                          ),
                        ),
                        Text(
                          product.name ?? 'Nama Produk Tidak Tersedia',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          product.name ?? 'Nama Produk Tidak Tersedia',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 30),
                      ]
                    ),
                  const SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 4, 2),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "IDR ${product.pricePerDay?.toStringAsFixed(0) ?? '0'}/day",
                        style: const TextStyle(fontSize: 16, color: Colors.deepOrange),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
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