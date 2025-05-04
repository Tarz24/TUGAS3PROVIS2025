import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ProductPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedVariant = "2 Orang";

  @override
  Widget build(BuildContext context) {
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
                    Image.asset(
                      "assets/tenda.jpg",
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
                  child: Row(
                    children: [
                      BadgeLabel(label: "HOT", color: Colors.orange),
                      SizedBox(width: 8),
                      BadgeLabel(label: "RECOMMENDED", color: Colors.green),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "TENDA CAMPING CONSINA",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Barang berkualitas ya kak, kita pastikan QC sebelum kirim. Silakan langsung di pesan, pengiriman 1x24 jam ya ka.\n\nTenda camping otomatis untuk 2 - 4 orang.\nWarna: hijau, biru, oranye.\n\nNote:\nCantumkan warna cadangan saat order, jika stok kosong dikirim warna random sesuai stok yang ada. Pesanan tetap diproses kecuali ada keterangan cancel.",
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
                    children: [
                      VariantButton(
                        label: "2 Orang",
                        isSelected: selectedVariant == "2 Orang",
                        onTap: () {
                          setState(() {
                            selectedVariant = "2 Orang";
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      VariantButton(
                        label: "3 Orang",
                        isSelected: selectedVariant == "3 Orang",
                        onTap: () {
                          setState(() {
                            selectedVariant = "3 Orang";
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      VariantButton(
                        label: "4 Orang",
                        isSelected: selectedVariant == "4 Orang",
                        onTap: () {
                          setState(() {
                            selectedVariant = "4 Orang";
                          });
                        },
                      ),
                    ],
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
          // aksi keranjang
        },
        child: Icon(Icons.shopping_cart, color: Colors.white),
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
