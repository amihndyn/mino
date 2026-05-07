import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mino/screens/on_boarding1.dart';
import 'login_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // 🔥 Animasi controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // 🔥 Pindah ke login setelah render pertama
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToLogin();
    });
  }

  // 🔥 Function pindah screen
  void _goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    _controller.stop(); // optional

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OnBoarding1(),
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
    return Scaffold(
      body: Stack(
        children: [
          // 🔥 BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF33211C),
                  Color(0xFF5A463E),
                ],
              ),
            ),
          ),

          // 🔥 GLOW
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

          // 
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

                  // 🔥 LOGO
                  Image.asset(
                    "assets/images/logo.png",
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

  // 🔥 DOT ANIMATION
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
        final animationValue = _controller.value;
        final dy =
            math.sin((animationValue * 2 * math.pi) + delay) * 8;

        final glow =
            (math.sin((animationValue * 2 * math.pi) + delay) + 1) / 2;

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
                  color: const Color(0xFFE5A84F)
                      .withOpacity(0.3 + (glow * 0.5)),
                  blurRadius: 4 + (glow * 6),
                  spreadRadius: 1 + (glow * 2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}