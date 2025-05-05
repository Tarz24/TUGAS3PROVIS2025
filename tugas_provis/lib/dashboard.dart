import 'package:flutter/material.dart';

// Import halaman-halaman dari file dart lain di lib/
// import 'logo.dart';
import 'login.dart';
import 'register.dart';
import 'main.dart';
import 'produk.dart';
import 'cart.dart';
import 'checkout.dart';
import 'chat.dart';
import 'profile.dart';
import 'notification.dart';
import 'information.dart';
import 'help.dart';
import 'faq.dart';


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
        // '/logo': (context) => LogoScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegistrasiScreen(),
        '/main': (context) => MainScreen(),
        '/detail': (context) => DetailScreen(),
        '/cart': (context) => KeranjangScreen(),
        '/checkout': (context) => CheckoutScreen(),
        '/chat': (context) => ChatScreen(),
        '/profile': (context) => ProfileScreen(),
        '/notification': (context) => NotificationScreen(),
        '/information': (context) => InformationScreen(),
        '/help': (context) => HelpScreen(),
        '/faq': (context) => FAQScreen(),
        '/admin': (context) => AdminScreen(),
        '/bug': (context) => BugScreen(),
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
    {'label': 'Detail Produk', 'route': '/detail'},
    {'label': 'Keranjang Screen', 'route': '/keranjang'},
    {'label': 'Checkout Screen', 'route': '/checkout'},
    {'label': 'Chat Screen', 'route': '/chat'},
    {'label': 'Profile Screen', 'route': '/profile'},
    {'label': 'Notification', 'route': '/notification'},
    {'label': 'Information', 'route': '/information'},
    {'label': 'Help', 'route': '/help'},
    {'label': 'FAQ', 'route': '/faq'},
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
