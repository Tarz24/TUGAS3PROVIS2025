import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_provis/viewmodels/auth_viewmodel.dart';
import 'package:tugas_provis/viewmodels/profile_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Pantau perubahan pada AuthViewModel dan ProfileViewModel
    final authViewModel = context.watch<AuthViewModel>();
    final profileViewModel = context.watch<ProfileViewModel>();

    return Scaffold(
      backgroundColor: Color(0xFFFFF7D4),
      body: Column(
        children: [
          Container(
            color: Colors.blue.shade900,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 15,
                right: 15,
                bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.menu, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Menampilkan UI berdasarkan state dari ProfileViewModel
          if (profileViewModel.isLoading)
            const CircleAvatar(
              radius: 60,
              child: CircularProgressIndicator(),
            )
          else if (profileViewModel.profile != null)
            Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      AssetImage('assets/images/profile.png'), // Placeholder
                ),
                SizedBox(height: 10),
                Text(
                  // Ambil nama dari viewmodel
                  '${profileViewModel.profile?.firstName ?? ''} ${profileViewModel.profile?.lastName ?? ''}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            )
          else
            // Tampilan jika data gagal dimuat
            const Text('Gagal memuat profil'),

          SizedBox(height: 20),
          ProfileButton(
            icon: Icons.notifications,
            label: 'Notification',
            onTap: () {
              // Navigator.pushNamed(context, '/notification'); (jika sudah ada)
            },
          ),
          ProfileButton(
            icon: Icons.description,
            label: 'Information',
            onTap: () {
               // Navigator.pushNamed(context, '/information'); (jika sudah ada)
            },
          ),
          ProfileButton(
            icon: Icons.headset_mic,
            label: 'Help',
             onTap: () {
               // Navigator.pushNamed(context, '/help'); (jika sudah ada)
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton.icon(
              onPressed: () async {
                // Panggil fungsi signOut dari AuthViewModel
                await authViewModel.signOut();
                // Navigasi akan ditangani secara otomatis oleh AuthGate
              },
              icon: authViewModel.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(Icons.logout, color: Colors.black),
              label: Text(
                'Log Out',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade400,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.black),
              ),
              SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}