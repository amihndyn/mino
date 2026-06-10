import 'package:flutter/material.dart';

class ChooseAvatarPage extends StatelessWidget {
  const ChooseAvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final avatars = [
      'assets/images/man.png',
      'assets/images/astronout.png',
      'assets/images/woman.png',
    ];

    return Container(
      height: 320,

      decoration: const BoxDecoration(
        color: Color(0xFF2F211D),

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),

      child: Column(
        children: [
          const SizedBox(height: 24),

          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Choose Your Avatar',
            style: TextStyle(
              color: Color(0xFFF3E7D7),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: avatars.map((avatar) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, avatar);
                },

                child: Container(
                  width: 90,
                  height: 120,

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Center(
                    child: Image.asset(
                      avatar,
                      width: 70,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}