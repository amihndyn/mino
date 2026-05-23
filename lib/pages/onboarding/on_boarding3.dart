import 'package:flutter/material.dart';
import 'package:mino/screens/home_page.dart';
import 'package:mino/widgets/button/custom_button.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

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
              'assets/images/ob3.png',
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
                    Color(0x006B3414), // transparan
                    Color(0x666B3414), // mulai gelap (~40%)
                    Color(0xCC6B3414), // lebih gelap (~80%)
                    Color(0xFF6B3414), // solid                 // bawah solid
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
                    "Find your diamond",
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
                    "Discover the rewards of your persistence",
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
                      dot(false),
                      dot(false),
                      dot(true),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 🔘 BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                    text: "Let’s Get Started",
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePage(),
                        ),
                      );
                    },
                  )
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