import 'package:flutter/material.dart';
import 'package:tugas_provis/login.dart';
import 'package:tugas_provis/supabase_client.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final Future<Map<String, dynamic>> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _getProfile();
  }

  Future<Map<String, dynamic>> _getProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final data =
        await supabase.from('profiles').select().eq('id', userId).single();
    return data;
  }

  // Fungsi untuk Log Out
  Future<void> _signOut() async {
    // Gunakan context sebelum async gap
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await supabase.auth.signOut();
      
      // Kembali ke halaman login dan hapus semua rute sebelumnya
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text('Gagal keluar: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7D4),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
                child: Text(
                    'Gagal memuat profil: ${snapshot.error ?? "Data tidak ditemukan"}'));
          }

          final profileData = snapshot.data!;
          final fullName =
              '${profileData['first_name'] ?? ''} ${profileData['last_name'] ?? ''}'
                  .trim();

          return Column(
            children: [
              // Header
              Container(
                color: Colors.blue.shade900,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 15,
                    right: 15,
                    bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                        width: 48), // Placeholder
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Foto profil (sementara)
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(height: 10),
              // Nama dinamis
              Text(
                fullName.isNotEmpty ? fullName : 'Nama Tidak Tersedia',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              ProfileButton(
                icon: Icons.notifications,
                label: 'Notification',
              ),
              ProfileButton(
                icon: Icons.description,
                label: 'Information',
              ),
              ProfileButton(
                icon: Icons.headset_mic,
                label: 'Help',
              ),
              const Spacer(),
              // Tombol Log Out yang berfungsi
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton.icon(
                  onPressed: _signOut, // Memanggil fungsi sign out
                  icon: const Icon(Icons.logout, color: Colors.black),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

// Widget tombol tidak perlu diubah
class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.black),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
