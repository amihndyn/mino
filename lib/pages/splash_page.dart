import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/constants/app_colors.dart';

// Import halaman navigasi Anda
import 'package:mino/pages/onboarding/on_boarding1.dart';
import 'package:mino/pages/auth/login_page.dart'; 
import 'package:mino/pages/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Inisialisasi animasi floating dots dari kode lama
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _checkNavigationLogic();
  }

  Future<void> _checkNavigationLogic() async {
    // 1. Ambil instansi SharedPreferences & AuthLocalDatasource bersamaan
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    final isLogin = await AuthLocalDatasource().isLogin();

    // 2. Efek delay splash screen (3 detik sesuai kode lama)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // Hentikan animasi sebelum pindah page
    _controller.stop();

    // 3. LOGIKA NAVIGASI GABUNGAN
    Widget destinationPage;
    if (isFirstTime) {
      destinationPage = const OnBoarding1();
    } else {
      destinationPage = isLogin ? const HomePage() : const LoginPage();
    }

    // 4. Pindah halaman menggunakan animasi FadeTransition bawaan kode lama kamu
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
        transitionDuration: const Duration(milliseconds: 800), 
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Memakai UI kosmetik lengkap yang diambil dari kode lama kamu
    return Scaffold(
      backgroundColor: AppColors.coklat900,
      body: Stack(
        children: [
          // Background Utama
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // GLOW EFFECT
          Center(
            child: Container(
              width: 370,
              height: 370,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00BBFF).withOpacity(0.5), 
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // LOGO DAN ANIMASI TITIK
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildAnimatedDot(left: 40, top: 80, size: 4, delay: 0.0),
                  _buildAnimatedDot(right: 50, top: 100, size: 6, delay: 1.5),
                  _buildAnimatedDot(left: 70, bottom: 90, size: 5, delay: 0.8),
                  _buildAnimatedDot(right: 80, bottom: 70, size: 4, delay: 2.2),
                  _buildAnimatedDot(left: 140, top: 50, size: 3, delay: 1.0),
                  
                  // Logo Utama
                  SvgPicture.asset(
                    'assets/images/logo.svg', 
                    width: 160,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedDot({
    double? left,
    double? right,
    double? top,
    double? bottom,
    required double size,
    required double delay,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final v = _controller.value;
        final dy = math.sin((v * 2 * math.pi) + delay) * 8;
        final glow = (math.sin((v * 2 * math.pi) + delay) + 1) / 2;

        return Positioned(
          left: left,
          right: right,
          top: top != null ? top + dy : null,
          bottom: bottom != null ? bottom - dy : null,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE5A84F),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE5A84F).withOpacity(0.3 + glow * 0.5), 
                  blurRadius: 4 + glow * 6,
                  spreadRadius: 1 + glow * 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}