// lib/main.dart (Dummy untuk Uji Coba Tabel Notes)

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Muat environment variables dari file .env
  await dotenv.load(fileName: ".env");

  // Inisialisasi Supabase dengan URL dan Anon Key Anda
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const UjiCobaSupabaseApp());
}

// Instance Supabase agar mudah diakses
final supabase = Supabase.instance.client;

class UjiCobaSupabaseApp extends StatelessWidget {
  const UjiCobaSupabaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uji Coba Tabel Notes',
      theme: ThemeData.light(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future untuk mengambil semua data dari tabel 'notes'
  final _future = supabase.from('notes').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uji Baca Data dari Tabel "notes"'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          // 1. Tampilkan loading spinner saat data sedang diambil
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // 2. Tampilkan pesan error jika terjadi masalah
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('TERJADI ERROR: ${snapshot.error}\n\n'
                            'Pastikan:\n'
                            '1. URL & Anon Key di file .env sudah benar.\n'
                            '2. Nama tabel adalah "notes".\n'
                            '3. RLS untuk tabel "notes" sudah dinonaktifkan.',
                            style: const TextStyle(color: Colors.red)),
              ),
            );
          }
          
          // 3. Tampilkan data jika berhasil diambil
          final notes = snapshot.data!;
          if (notes.isEmpty) {
            return const Center(child: Text('Tabel "notes" kosong. Silakan isi data contoh terlebih dahulu di Supabase.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                child: ListTile(
                  title: Text(
                    note['title'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(note['body'].toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}