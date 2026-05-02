import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 🔥 Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔥 Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // 💎 Diamond
                    SvgPicture.asset('assets/icons/diamond.svg', height: 100),

                    const SizedBox(height: 30),

                    const Text(
                      "Sign Up for Mino",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Start your journey",
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 30),

                    // 👤 Name
                    const CustomTextField(hint: "Your name"),

                    const SizedBox(height: 15),

                    // 📧 Email
                    const CustomTextField(hint: "Email"),

                    const SizedBox(height: 15),

                    // 🔒 Password
                    const CustomTextField(hint: "Password", isPassword: true),

                    const SizedBox(height: 20),

                    // 🔥 Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Sign Up"),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.white30)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white30)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔵 Google Button
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google.png', height: 20),
                          const SizedBox(width: 10),
                          const Text("continue with google"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🔁 Navigate ke login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
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
