import 'package:flutter/material.dart';
import 'package:tugas_provis/login.dart';
import 'package:tugas_provis/register.dart';
import 'package:tugas_provis/menu.dart';

import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ... import lainnya

Future<void> main() async {
  // Kode yang WAJIB ada sebelum runApp()
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  // Akhir dari kode wajib

  runApp(const MyApp());
}

// Buat instance client agar mudah diakses di file lain
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAMPRENT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/menu': (context) => const MenuScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1. Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // LOGIKA BARU: Ganti Timer dengan fungsi pengecekan sesi
    _redirect();
  }

  // FUNGSI BARU: untuk mengecek sesi login
  Future<void> _redirect() async {
    // Tunggu sesaat (agar build context siap)
    await Future.delayed(Duration.zero);
    if (!mounted) return; // Pastikan widget masih ada di tree

    final session = supabase.auth.currentSession;
    if (session != null) {
      // Jika ada sesi aktif, langsung ke halaman menu
      Navigator.pushReplacementNamed(context, '/menu');
    } else {
      // Jika tidak ada sesi, ke halaman login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TAMPILAN LAMA ANDA: Bagian ini tetap sama, tidak perlu diubah.
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'), //
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
                        'assets/images/logo.png', //
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



