import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
import 'package:mino/pages/auth/login_page.dart';
import 'package:mino/pages/home/home_page.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mino/core/constants/app_colors.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900, // Mencegah kedip putih
      body: Stack(
        children: [
          // ── Background Utama (Diubah ke SVG) ───────────────────────
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          // ── Ilustrasi Onboarding (Diubah ke SVG) ───────────────────
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/ob3.svg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          // ── Efek Gradient Overlay ──────────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x006B3414),
                    Color(0x666B3414),
                    Color(0xCC6B3414),
                    Color(0xFF6B3414),
                  ],
                  stops: [0.4, 0.65, 0.85, 1.0],
                ),
              ),
            ),
          ),

          // ── Konten Teks & Tombol Kontrol ───────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Find your diamond',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE6A84A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Discover the rewards of your persistence',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE6A84A),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [dot(false), dot(false), dot(true)],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Let's Get Started",
                      // 1. Ubah onTap menjadi async
                      onTap: () async {
                        // 2. Simpan status isFirstTime menjadi false
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isFirstTime', false);

                        // 3. Pastikan context masih valid
                        if (!context.mounted) return;

                        // Transisi Fade yang mulus sebelum ke LoginPage
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const LoginPage(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 12 : 8,
      height: active ? 12 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.orange : Colors.white38,
        shape: BoxShape.circle,
      ),
    );
  }
}
