import 'package:flutter/material.dart';
import 'package:tugas_provis/information.dart';
import 'package:tugas_provis/notification.dart'; 
// import 'package:tugas_provis/help.dart';
import 'package:tugas_provis/login.dart';
import 'package:tugas_provis/supabase_client.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _profileFuture;

  // Fungsi untuk membuka WhatsApp (sudah ada)
  Future<void> _launchWhatsApp() async {
    const String phoneNumber = '6285775712437'; // Nomor WA Admin
    const String message = 'Halo, saya perlu bantuan dari CAMPRENT.';
    final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka WhatsApp. Pastikan aplikasi sudah terinstal.')),
        );
      }
    }
  }

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

  void _refreshProfile() {
    setState(() {
      _profileFuture = _getProfile();
    });
  }

  Future<void> _signOut() async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await supabase.auth.signOut();
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
                    const SizedBox(width: 48), // Placeholder
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(height: 10),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationPage()),
                  );
                },
              ),
              ProfileButton(
                icon: Icons.description,
                label: 'Information',
                onTap: () async { 
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InformationPage()),
                  );
                  _refreshProfile();
                },
              ),
              // ===== PERUBAHAN DI SINI =====
              ProfileButton(
                icon: Icons.headset_mic,
                label: 'Help',
                onTap: _launchWhatsApp, // Mengarahkan ke fungsi WhatsApp
              ),
              // ===== AKHIR PERUBAHAN =====
              const Spacer(),
              // Tombol Log Out
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton.icon(
                  onPressed: _signOut,
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

// Widget tombol diubah sedikit untuk menerima onTap
class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap; // Menambahkan parameter onTap

  const ProfileButton({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell( // Dibungkus dengan InkWell agar bisa ditekan
        onTap: onTap,
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
      ),
    );
  }
}
