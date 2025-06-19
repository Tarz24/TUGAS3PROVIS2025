import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_provis/viewmodels/auth_viewmodel.dart';

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
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final firstName = firstnameController.text;
    final lastName = lastnameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    bool formIsValid = true;

    if (email.isEmpty || !email.contains('@')) {
      // Bagaimana cara menampilkan error di bawah TextFormField email?
      // Sangat rumit! Anda harus membuat state sendiri untuk pesan error.
      print("Error: Email tidak valid");
      formIsValid = false;
    }
    
    if (password.isEmpty || password.length < 6) {
      // Bagaimana cara menampilkan error di bawah TextFormField password?
      print("Error: Password kosong");
      formIsValid = false;
    } else if (password.length < 6) {
      print("Error: Password harus lebih dari karakter");
      formIsValid = false;
    }

    if (firstName.isEmpty) {
      // Bagaimana cara menampilkan error di bawah TextFormField password?
      print("Error: First Name kosong");
      formIsValid = false;
    }

    if (lastName.isEmpty) {
      // Bagaimana cara menampilkan error di bawah TextFormField password?
      print("Error: Last Name kosong");
      formIsValid = false;
    }

    if (formIsValid) {
      final viewModel = context.read<AuthViewModel>();
      final isSuccess = await viewModel.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        firstName: firstnameController.text.trim(),
        lastName: lastnameController.text.trim(),
      );

      if (mounted) {
        if (isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pendaftaran berhasil! Silakan cek email Anda.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(viewModel.errorMessage ?? 'Terjadi kesalahan.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;

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
                        onPressed: isLoading ? null : () {
                          if (passwordController.text == confirmPasswordController.text) {
                            // print('First Name: ${firstnameController.text}');
                            // print('Last Name: ${lastnameController.text}');
                            // print('Email: ${emailController.text}');
                            // print('Password: ${passwordController.text}');
                            _handleRegister();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Passwords do not match!')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text(
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
