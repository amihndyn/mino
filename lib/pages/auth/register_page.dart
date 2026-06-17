import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mino/pages/auth/login_page.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/constants/app_colors.dart'; // Memastikan import warna aktif

import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/providers/auth_provider.dart'; 
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

  Future<void> _onRegisterTap() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      CustomToast.show(
        context: context,
        message: 'All fields must be filled out',
        isSuccess: false,
      );
      return;
    }

    if (password != confirmPassword) {
      CustomToast.show(
        context: context,
        message: 'Passwords do not match',
        isSuccess: false,
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    
    final errorMessage = await authProvider.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: confirmPassword,
    );

    if (!mounted) return;

    if (errorMessage == null) {
      // 🟢 JIKA BERHASIL: Muncul Toast dari atas selama 1.3 detik
      CustomToast.show(
        context: context,
        message: 'Registration successful! Welcome to Mino.',
        isSuccess: true,
      );
      
      // Memberikan sedikit nafas agar animasi selesai sebelum pindah page
      Future.delayed(const Duration(milliseconds: 1400), () {
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
        );
      });
    } else {
      // 🔴 JIKA GAGAL: Muncul Toast gagal dari atas selama 1.3 detik
      CustomToast.show(
        context: context,
        message: errorMessage,
        isSuccess: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24, 
                  right: 24,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20, 
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    SvgPicture.asset('assets/icons/diamond.svg', height: 100),
                    const SizedBox(height: 30),
                    const Text(
                      'Join Mino',
                      style: TextStyle(
                        fontSize: 36, 
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
                              : CustomButton(
                                  text: 'Register',
                                  onTap: _onRegisterTap,
                                ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white30, thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white30, thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
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
                            Image.asset('assets/images/google.png', height: 30),
                            const SizedBox(width: 10),
                            const Text(
                              'Continue with google',
                              style: TextStyle(
                                color: Colors.black87, 
                                fontWeight: FontWeight.w500,
                                fontSize: 16
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
    );
  }
}

// 🔥 WIDGET ENGINE UTAMA UNTUK MENGELUARKAN POPUP SLIDE DARI ATAS LAYAR (1.3 DETIK)
class CustomToast {
  static void show({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        isSuccess: isSuccess,
        onDismiss: () => overlayEntry.remove(),
      ),
    );

    overlayState.insert(overlayEntry);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final bool isSuccess;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.isSuccess,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.5), // Dropdown dari luar batas atas layar
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    // Timer penahanan popup persis 1.3 Detik (1300 ms) sebelum ditarik kembali ke atas
    Future.delayed(const Duration(milliseconds: 1300), () async {
      if (mounted) {
        await _controller.reverse();
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double scale = (MediaQuery.sizeOf(context).width / 375).clamp(0.8, 1.2);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 10 * scale),
          child: SlideTransition(
            position: _offsetAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
                decoration: BoxDecoration(
                  color: widget.isSuccess ? AppColors.orange100 : const Color(0xFFFBF4EB),
                  borderRadius: BorderRadius.circular(40 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.isSuccess ? Icons.check_circle : Icons.cancel,
                      color: widget.isSuccess ? const Color(0xFF22C55E) : Colors.red,
                      size: 24 * scale,
                    ),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          color: const Color(0xFF261C14),
                          fontSize: 13 * scale,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _controller.reverse();
                        widget.onDismiss();
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: const Color(0xFF261C14).withOpacity(0.6),
                        size: 20 * scale,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}