import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
import 'package:mino/pages/onboarding/on_boarding3.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Mencegah kedip putih
      body: Stack(
        children: [
          // ── Background Utama (Diubah ke SVG) ───────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // ── Ilustrasi Onboarding (Diubah ke SVG) ───────────────────
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/ob2.svg',
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
                    Colors.transparent,
                    Color(0x66482613),
                    Color(0xCC482613),
                    Color(0xFF482613),
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
                    'Stay consistent',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE6A84A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Dig deeper every day with focused effort',
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
                    children: [dot(false), dot(true), dot(false)],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Next',
                      onTap: () {
                        // Transisi Fade yang mulus menuju halaman berikutnya
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const OnBoarding3(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                          ),
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