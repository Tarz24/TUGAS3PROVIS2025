import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tugas_provis/supabase_client.dart'; // Pastikan import ini ada

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  // Controller untuk setiap text field
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Variabel untuk menyimpan nilai awal, untuk perbandingan
  String _initialFirstName = '';
  String _initialLastName = '';

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    // Selalu dispose controller untuk menghindari memory leak
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // --- LOGIKA PENGAMBILAN DATA ---
  Future<void> _getProfile() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) throw 'User not logged in';

      final response = await supabase
          .from('profiles')
          .select('first_name, last_name')
          .eq('id', userId)
          .single();
      
      // Isi controller dan simpan nilai awal
      _initialFirstName = response['first_name'] ?? '';
      _initialLastName = response['last_name'] ?? '';
      _firstNameController.text = _initialFirstName;
      _lastNameController.text = _initialLastName;
      _emailController.text = supabase.auth.currentUser!.email!;

    } catch (e) {
      if (mounted) _showErrorSnackBar('Gagal memuat data profil: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // --- LOGIKA MENYIMPAN SEMUA PERUBAHAN ---
  Future<void> _saveChanges() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    bool profileChanged = _firstNameController.text != _initialFirstName || 
                          _lastNameController.text != _initialLastName;
    bool passwordChanged = _passwordController.text.isNotEmpty;

    if (!profileChanged && !passwordChanged) {
      _showInfoSnackBar('Tidak ada perubahan untuk disimpan.');
      setState(() => _isSaving = false);
      return;
    }

    try {
      // 1. Update Profile (Nama) jika ada perubahan
      if (profileChanged) {
        final userId = supabase.auth.currentUser!.id;
        await supabase.from('profiles').update({
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
        }).eq('id', userId);

        // Update nilai awal setelah berhasil
        _initialFirstName = _firstNameController.text;
        _initialLastName = _lastNameController.text;
      }

      // 2. Update Password jika ada perubahan
      if (passwordChanged) {
        if (_passwordController.text != _confirmPasswordController.text) {
          throw 'Konfirmasi password tidak cocok!';
        }
        await supabase.auth.updateUser(
          UserAttributes(password: _passwordController.text),
        );
        _passwordController.clear();
        _confirmPasswordController.clear();
      }

      _showSuccessSnackBar('Perubahan berhasil disimpan!');
      FocusScope.of(context).unfocus();

    } catch (e) {
      _showErrorSnackBar('Gagal menyimpan perubahan: $e');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  // Helper untuk menampilkan notifikasi
  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red));
  }
   void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green));
  }
   void _showInfoSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8D7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F497B),
        centerTitle: true,
        title: const Text('Information',
            style: TextStyle(fontSize: 24, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(height: 24),
                  
                  // Semua form sekarang bisa diubah, kecuali email
                  _textField(label: 'First Name:', controller: _firstNameController),
                  _textField(label: 'Last Name:', controller: _lastNameController),
                  _textField(label: 'E-mail:', controller: _emailController, enabled: false),
                  
                  _textField(label: 'Change Password:', controller: _passwordController, isPassword: true),
                  _textField(label: 'Confirm Password:', controller: _confirmPasswordController, isPassword: true),
                  
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F497B),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSaving
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        : const Text('Simpan Perubahan', style: TextStyle(color: Colors.white, fontSize: 16)),
                  )
                ],
              ),
            ),
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            enabled: enabled,
            obscureText: isPassword,
            decoration: InputDecoration(
              filled: true,
              fillColor: enabled ? Colors.white : Colors.grey[300],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}