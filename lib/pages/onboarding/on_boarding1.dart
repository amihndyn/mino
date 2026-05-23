import 'package:flutter/material.dart';
import 'package:mino/pages/onboarding/on_boarding2.dart';
import 'package:mino/pages/onboarding/on_boarding3.dart';
import 'package:mino/widgets/button/custom_button.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔥 IMAGE UTAMA (OB2)
          Positioned.fill(
            child: Image.asset(
              'assets/images/ob1.png',
              fit: BoxFit.cover, // ⬅️ ini penting biar ga gepeng
              alignment: Alignment.center,
            ),
          ),

          // 🌫 OVERLAY DARI BAWAH (INI YANG KAMU MAU)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, // atas bening
                    Color(0x66482613), // mulai gelap
                    Color(0xCC482613), // lebih gelap
                    Color(0xFF211A1A), // bawah solid
                  ],
                  stops: [0.4, 0.65, 0.85, 1.0],
                ),
              ),
            ),
          ),

          // 🔵 CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 80,
                right: 80,
                bottom: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // 📝 TITLE
                  const Text(
                    "Build your habits",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE6A84A),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 📝 DESC
                  const Text(
                    "Start your journey by creating meaningful habits",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE6A84A),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 🔘 DOT INDICATOR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dot(true),
                      dot(false),
                      dot(false),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 🔘 BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Next",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OnBoarding2(),
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

  // 🔘 DOT INDICATOR
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