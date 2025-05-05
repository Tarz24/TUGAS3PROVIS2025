// Tambahan di bagian atas tetap sama
import 'package:flutter/material.dart';

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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
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
                                    image: AssetImage('assets/images/tenda.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.black, style: BorderStyle.solid),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 255, 149, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Hot Deal", style: TextStyle(color: Colors.black)),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 84, 255, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Recommended", style: TextStyle(color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        'Tenda Camping Consina',
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "IDR 120.000/day",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                  
                  // Produk 2
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
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
                                    image: AssetImage('assets/images/sepatu.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.black, style: BorderStyle.solid),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 255, 149, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Hot Deal", style: TextStyle(color: Colors.black)),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 84, 255, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Recommended", style: TextStyle(color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        'Sepatu Outdoor OWEN',
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "IDR 45.000/day",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),

                  // Produk 3
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
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
                                    image: AssetImage('assets/images/tas.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.black, style: BorderStyle.solid),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 255, 149, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Hot Deal", style: TextStyle(color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        'Carrier 55+5 L Bahan Cordura',
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "IDR 55.000/day",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),

                  // Produk 4
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
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
                                    image: AssetImage('assets/images/sleeping_bag.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.black, style: BorderStyle.solid),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 255, 149, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Hot Deal", style: TextStyle(color: Colors.black)),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 84, 255, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Recommended", style: TextStyle(color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        'Sleepingbag Polar Tebal+Bantal',
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "IDR 25.000/day",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),

                  // Produk 5
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
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
                                    image: AssetImage('assets/images/sleeping_bag4.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.black, style: BorderStyle.solid),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 255, 149, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Hot Deal", style: TextStyle(color: Colors.black)),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 84, 255, 0),
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Text("Recommended", style: TextStyle(color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      const Text(
                                        'L.L.Bean Adventure 30° Sleeping Bag',
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "IDR 30.000/day",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
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
