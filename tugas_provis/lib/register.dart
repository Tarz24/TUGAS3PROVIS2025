import 'package:flutter/material.dart';

import 'package:tugas_provis/supabase_client.dart';

void main() {
  runApp(const RegisterScreen());
}

// 3. Register Screen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
        child: SafeArea(
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        width: 150,
                        height: 150,
                        child: Image(
                          image: AssetImage('assets/images/logo2.png')
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      buildTextField('First Name', firstnameController),
                      const SizedBox(height: 20),
                      buildTextField('Last Name', lastnameController),
                      const SizedBox(height: 20),
                      buildTextField('E-mail', emailController, isEmail: true),
                      const SizedBox(height: 20),
                      buildTextField('Password', passwordController, isPassword: true),
                      const SizedBox(height: 20),
                      buildTextField('Confirm password', confirmPasswordController, isPassword: true),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          // Ambil input dari text field
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          final firstName = firstnameController.text.trim();
                          final lastName = lastnameController.text.trim();

                          // Panggil Supabase Auth
                          try {
                            final authResponse = await supabase.auth.signUp(
                              email: email,
                              password: password,
                              // 'data' ini akan ditangkap oleh Trigger yang kita buat
                              data: {'first_name': firstName, 'last_name': lastName},
                            );

                            // Tampilkan pesan sukses jika berhasil
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Registrasi Berhasil! Silakan cek email untuk verifikasi.'),
                                backgroundColor: Colors.green,
                              ));
                              Navigator.pop(context); // Kembali ke halaman login
                            }

                          } catch (e) {
                            // Tampilkan pesan error jika gagal
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Error: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(96, 131, 131, 131),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sudah Punya Akun ? ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, 
      {bool isPassword = false, bool isEmail = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          obscureText: isPassword,
          keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        ),
      ],
    );
  }
}
