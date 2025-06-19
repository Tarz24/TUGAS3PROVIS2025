import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Menu/menu.dart'; // Ganti dengan halaman utama Anda
import 'login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final session = snapshot.data!.session;
          if (session != null) {
            // Jika ada sesi (sudah login), tampilkan halaman utama
            return const MenuScreen();
          } else {
            // Jika tidak ada sesi, tampilkan halaman login
            return const LoginScreen();
          }
        }
        // Saat koneksi awal, tampilkan loading
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}