import 'package:flutter/material.dart';
import 'challenge_progress_card.dart';

class ChallengeSection extends StatelessWidget {
  const ChallengeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Challenge",
          style: TextStyle(
            color: Color(0xffF2CD94), // Warna emas/krem disesuaikan
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        
        SizedBox(height: 16),

        // Kartu Pertama (Diubah ke .svg)
        ChallengeProgressCard(
          title: "Release tension in your body",
          imageAsset: 'assets/images/note2.svg',
          currentProgress: 12,
          totalProgress: 30,
        ),
        
        SizedBox(height: 12),

        // Kartu Kedua (Diubah ke .svg)
        ChallengeProgressCard(
          title: "Clean your home",
          imageAsset: 'assets/images/clean_home.svg',
          currentProgress: 5,
          totalProgress: 30,
        ),
      ],
    );
  }
}