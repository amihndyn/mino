import 'package:flutter/material.dart';
import 'package:mino/pages/home/home_page.dart';

class ConfirmPassword4 extends StatefulWidget {
  const ConfirmPassword4({super.key});

  @override
  ConfirmPassword4State createState() => ConfirmPassword4State();
}

class ConfirmPassword4State extends State<ConfirmPassword4> {
  // 1. PERBAIKAN: Set langsung ke true agar lingkaran otomatis melompat dari awal
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // 2. PERBAIKAN: Jalankan fungsi verifikasi otomatis saat halaman pertama kali dibuka
    _verifyPasswordAndNavigate();
  }

  void _verifyPasswordAndNavigate() async {
    // Simulasi proses loading/verifikasi otomatis selama 2.5 detik
    await Future.delayed(const Duration(milliseconds: 2500));
    
    if (!mounted) return;

    setState(() {
      isLoading = false; // Matikan animasi tepat sebelum pindah halaman
    });

    // Transisi halus (Fade & Scale) menuju Dashboard
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          var scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. BACKGROUND FULL SCREEN
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

          // 2. INDIKATOR 4 LINGKARAN PIN (Otomatis Melompat)
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return BouncingCircle(
                  index: index,
                  isAnimating: isLoading,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// WIDGET KUSTOM: LINGKARAN YANG BISS MELOMPAT
// ==========================================
class BouncingCircle extends StatefulWidget {
  final int index;
  final bool isAnimating;

  const BouncingCircle({
    super.key,
    required this.index,
    required this.isAnimating,
  });

  @override
  State<BouncingCircle> createState() => _BouncingCircleState();
}

class _BouncingCircleState extends State<BouncingCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: -15.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isAnimating) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant BouncingCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating && !oldWidget.isAnimating) {
      _startAnimation();
    } else if (!widget.isAnimating && oldWidget.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  void _startAnimation() async {
    // Jeda antar lingkaran agar melompat bergantian membentuk gelombang
    await Future.delayed(Duration(milliseconds: widget.index * 150));
    if (!mounted) return;
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isAnimating ? const Color(0xffF2CD94) : Colors.transparent,
          border: Border.all(
            color: const Color(0xffF2CD94), 
            width: 2.5,
          ),
        ),
      ),
    );
  }
}