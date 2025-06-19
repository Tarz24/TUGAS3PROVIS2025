// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Import yang disesuaikan dengan struktur baru
import 'package:tugas_provis/auth_gate.dart';
import 'package:tugas_provis/features/authentication/view/login.dart';
import 'package:tugas_provis/features/authentication/view/register.dart';
import 'package:tugas_provis/features/home/view/menu.dart';
import 'package:tugas_provis/features/product/view/produk.dart';
import 'package:tugas_provis/features/profile/view/profile.dart';
import 'package:tugas_provis/viewmodels/auth_viewmodel.dart';
import 'package:tugas_provis/viewmodels/product_viewmodel.dart';
import 'package:tugas_provis/viewmodels/profile_viewmodel.dart';
import 'package:tugas_provis/viewmodels/cart_viewmodel.dart';

import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Muat environment variables dari file .env
  await dotenv.load(fileName: ".env");

  // Inisialisasi Supabase dengan URL dan Anon Key Anda
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftarkan semua ViewModel di sini menggunakan MultiProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => ProductViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
      ],
      child: MaterialApp(
        title: 'Tes Database MVVM',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          useMaterial3: true,
          fontFamily: 'Arial',
        ),
        home: const SplashScreen(), // Halaman utama kita
        routes: {
            // Rute disesuaikan dengan import yang benar
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/menu': (context) => const MenuScreen(),
            '/product-detail': (context) => const ProductPage(),
            '/profile': (context) => const ProfilePage(),
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set timer untuk pindah ke halaman login setelah 5 detik
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        // Navigasi ke AuthGate setelah SplashScreen
        MaterialPageRoute(builder: (context) => const AuthGate()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'CAMPRENT™',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}