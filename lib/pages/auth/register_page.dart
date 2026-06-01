import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mino/core/presentation/auth/bloc/register/register_bloc.dart';
import 'package:mino/pages/onboarding/on_boarding1.dart';
import 'package:mino/widgets/button/custom_button.dart';
import '../../widgets/textfields/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterTap() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua field harus diisi')));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password dan konfirmasi password tidak cocok'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<RegisterBloc>().add(
      RegisterEvent.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: confirmPassword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registrasi berhasil!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const OnBoarding1()),
              (route) => false,
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.black, // Tambahan untuk transisi yang mulus
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // PERBAIKAN: Background dipaksa melar menutupi seluruh layar
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24, // Disamakan dengan halaman Login
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
                        'Join Mino',
                        style: TextStyle(
                          fontSize: 36, // Sedikit disesuaikan agar rapi
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Start your journey',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 40),
                      
                      CustomTextField(
                        hintText: 'Your name',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        hintText: 'Email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        hintText: 'Password',
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        hintText: 'Confirm Password',
                        isPassword: true,
                        controller: _confirmPasswordController,
                      ),
                      
                      const SizedBox(height: 24),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          );
                          return SizedBox(
                            // PERBAIKAN: Lebar tombol jadi double.infinity
                            width: double.infinity,
                            height: 50,
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.orange,
                                    ),
                                  )
                                : CustomButton(
                                    text: 'Register',
                                    onTap: _onRegisterTap,
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
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
                      const SizedBox(height: 20),
                      
                      // PERBAIKAN: Tombol Google dibuat konsisten dengan LoginPage
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
                              Image.asset('assets/images/google.png', height: 20),
                              const SizedBox(width: 10),
                              const Text(
                                'Continue with google',
                                style: TextStyle(
                                  color: Colors.black87, 
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}