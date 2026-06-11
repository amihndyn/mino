import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mino/pages/auth/confirm_password_screen.dart';
import 'package:mino/pages/auth/register_page.dart';
import 'package:mino/widgets/textfields/custom_textfield.dart';
import '../../widgets/button/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:mino/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // HAPUS bool _isLocalLoading = false; dari atas karena kita pakai Provider sekarang

  // UBAH FUNGSI LOGIN MENJADI SEPERTI INI
  Future<void> _onLoginTap() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password tidak boleh kosong')),
      );
      return;
    }

    // Panggil AuthProvider untuk melakukan http request ke Laravel
    final authProvider = context.read<AuthProvider>();

    // Tunggu proses login ke API selesai
    final errorMessage = await authProvider.login(
      email: email,
      password: password,
    );

    if (!mounted) return;

    if (errorMessage == null) {
      // JIKA BERHASIL LOGIN (Token berhasil disimpan)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil!'),
          backgroundColor: Colors.green,
        ),
      );

      // Pindah ke Dashboard (Pastikan tujuannya benar ke halaman utama)
      Navigator.pushAndRemoveUntil(
        context,
        // Ganti ConfirmPassword4() dengan halaman tujuan aslimu, misal Dashboard() atau MainNavBar()
        MaterialPageRoute(builder: (_) => const ConfirmPassword4()),
        (route) => false,
      );
    } else {
      // JIKA GAGAL (Sandi salah, email tidak ada, dll)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. BACKGROUND FULL SCREEN (Diubah ke SVG)
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          // 2. KONTEN UTAMA
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    SvgPicture.asset('assets/icons/diamond.svg', height: 100),
                    const SizedBox(height: 30),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Continue your journey',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 40),

                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      hintText: 'Password',
                      isPassword: true,
                      controller: _passwordController,
                    ),

                    const SizedBox(height: 24),

                    // Menggunakan state lokal, tombol tetap ada saat loading
                    // GANTI TOMBOL LAMA DENGAN CONSUMER INI
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: authProvider.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.orange,
                                  ),
                                )
                              : CustomButton(text: 'Login', onTap: _onLoginTap),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Forget the password?',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white30)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white30)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // DIUBAH KE SVG: Ikon Google
                            SvgPicture.asset(
                              'assets/images/google.svg',
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Continue with google',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFE6A84A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
