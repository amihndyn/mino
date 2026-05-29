import 'package:flutter/material.dart';

import 'challenge_progress_card.dart';

class ChallengeSection extends StatelessWidget {
  const ChallengeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: const [
        Text(
          "Challenge",
          style: TextStyle(
            color: Color(0xffE6A84A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 16),

        ChallengeProgressCard(),
      ],
    );
  }
}