import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelompok 2',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TampilanScreen(),
        '/logo': (context) => SimpleScreen(title: 'Logo Screen'),
        '/login': (context) => SimpleScreen(title: 'Login Screen'),
        '/registrasi': (context) => SimpleScreen(title: 'Registrasi Screen'),
        '/main': (context) => SimpleScreen(title: 'Main Screen'),
        '/search': (context) => SimpleScreen(title: 'Search')
        '/detail': (context) => SimpleScreen(title: 'Detail Produk'),
        '/keranjang': (context) => SimpleScreen(title: 'Keranjang Screen'),
        '/checkout': (context) => SimpleScreen(title: 'Checkout Screen'),
        '/chat': (context) => SimpleScreen(title: 'Chat Screen'),
        '/profile': (context) => SimpleScreen(title: 'Profile Screen'),
        '/notification': (context) => SimpleScreen(title: 'Notification'),
        '/information': (context) => SimpleScreen(title: 'Information'),
        '/help': (context) => SimpleScreen(title: 'Help'),
        '/faq': (context) => SimpleScreen(title: 'FAQ'),
        '/admin': (context) => SimpleScreen(title: 'Hubungi Admin'),
        '/bug': (context) => SimpleScreen(title: 'Laporan Masalah/Bug'),
      },
    );
  }
}

class TampilanScreen extends StatelessWidget {
  final List<Map<String, String>> screens = [
    {'label': 'Logo Screen', 'route': '/logo'},
    {'label': 'Login Screen', 'route': '/login'},
    {'label': 'Registrasi Screen', 'route': '/registrasi'},
    {'label': 'Main Screen', 'route': '/main'},
    {'label': 'Search', 'route': '/search'},
    {'label': 'Detail Produk', 'route': '/detail'},
    {'label': 'Keranjang Screen', 'route': '/keranjang'},
    {'label': 'Checkout Screen', 'route': '/checkout'},
    {'label': 'Chat Screen', 'route': '/chat'},
    {'label': 'Profile Screen', 'route': '/profile'},
    {'label': 'Notification', 'route': '/notification'},
    {'label': 'Information', 'route': '/information'},
    {'label': 'Help', 'route': '/help'},
    {'label': 'FAQ', 'route': '/FAQ'},
    {'label': 'Hubungi Admin', 'route': '/admin'},
    {'label': 'Laporan Masalah/Bug', 'route': '/bug'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber[50],
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.blue[800],
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Nomor Kelompok: 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Column(
                    children: screens.map((screen) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, screen['route']!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(screen['label']!),
                        ),
                      );
                    }).toList(),
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

// Template Screen Sementara
class SimpleScreen extends StatelessWidget {
  final String title;

  const SimpleScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
