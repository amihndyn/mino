import 'package:flutter/material.dart';

import 'streak_card.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Hi, Keysha",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Wednesday, April 22 2026",
              style: TextStyle(
                color: Color(0xffE6A84A),
                fontSize: 14,
              ),
            ),
          ],
        ),

        Row(
          children: [
            const StreakCard(),
            const SizedBox(width: 12),

            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150",
              ),
            ),
          ],
        )
      ],
    );
  }
}