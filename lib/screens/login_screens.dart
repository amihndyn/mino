import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 412,
          height: 917,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// 💎 DIAMOND
                SizedBox(
                  width: 107.95,
                  height: 87.65,
                  child: SvgPicture.asset('assets/icons/diamond.svg'),
                ),

                const SizedBox(height: 24),

                /// 📝 TITLE
                const Text(
                  "Welcome Back",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF5E6D3),
                  ),
                ),

                const SizedBox(height: 6),

                /// 📝 SUBTITLE
                const Text(
                  "Continue your journey",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFC9B8A3),
                  ),
                ),

                const SizedBox(height: 28),

                /// 📩 EMAIL
                const SizedBox(
                  width: 329,
                  height: 48,
                  child: CustomTextField(hint: "Email"),
                ),

                const SizedBox(height: 14),

                /// 🔑 PASSWORD
                const SizedBox(
                  width: 329,
                  height: 48,
                  child: CustomTextField(
                    hint: "Password",
                    isPassword: true,
                  ),
                ),

                const SizedBox(height: 22),

                /// 🔥 BUTTON (FIX SIZE)
                SizedBox(
                  width: 358,
                  height: 47,
                  child: CustomButton(
                    text: "Next",
                    onTap: () {
                      // TODO: handle login
                    },
                  ),
                ),

                const SizedBox(height: 14),

                /// ❓ FORGOT PASSWORD
                const Text(
                  "Forgot the password?",
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: Color(0xFF5A463E),
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 18),

                /// ➖ OR
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 111,
                      height: 1,
                      color: const Color(0xCCFFFFFF),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Or",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFE6A84A),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 111,
                      height: 1,
                      color: const Color(0xCCFFFFFF),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                /// 🔵 GOOGLE BUTTON
                Container(
                  width: 339,
                  height: 42,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 67,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xCCFFFFFF),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "continue with google",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5A463E),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                /// 🔗 SIGN UP
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignUpScreen(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}