import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 32),
                  Icon(Icons.menu, color: Colors.white),
                ],
              ),
            ),

            // Title
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF4A6880),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                "Check Out",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // Product Info
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/tenda.jpg',
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Tenda Camping Consina",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Text(
                        "IDR 120.000/day",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Jumlah Orang dan Hari
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _counterButton("2 Orang"),
                      _itemCounter(),
                      _dayCounter(),
                    ],
                  ),

                  const SizedBox(height: 8),
                  // Dropdown Placeholder
                ],
              ),
            ),

            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Selengkapnya"),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Alamat
            _sectionContainer(
              title: "Alamat",
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A6880)),
                    child: const Text(
                      "Antar",
                      style: TextStyle(color: Colors.white),
                      ),
                  )
                ],
              ),
            ),

            // Metode Pembayaran
            _sectionContainer(
              title: "Metode Pembayaran",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(""),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A6880)),
                    child: const Text("Pilih",
                      style: TextStyle(color: Colors.white))
                  )
                ],
              ),
            ),

            const Spacer(),

            // Footer
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF4A6880),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total\n-",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () {},
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

  Widget _counterButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF4A6880),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _itemCounter() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A6880),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove, color: Colors.white)),
          const Text("1", style: TextStyle(color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _dayCounter() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A6880),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove, color: Colors.white)),
          const Text("1 day", style: TextStyle(color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add, color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_today, color: Colors.white, size: 18)),
        ],
      ),
    );
  }

  Widget _sectionContainer({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title :", style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          child
        ],
      ),
    );
  }
}