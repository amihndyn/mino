import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'challenge_progress_card.dart';

class ChallengeSection extends StatelessWidget {
  const ChallengeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ // 🔥 MODIFIKASI: Hapus kata 'const' di sini agar tidak memicu error tumpukan widget
        const Text(
          "Challenge",
          style: TextStyle(
            color: AppColors.orange300, // Warna emas/krem
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        
        const SizedBox(height: 16),

        // Kartu Pertama (Disesuaikan ke asset .png yang kamu punya dari FindPage)
        const ChallengeProgressCard(
          title: "Release tension in your body",
          imageAsset: 'assets/images/note2.png', // 🔥 Diubah ke routine.png agar sesuai data asset kamu
          currentProgress: 12,
          totalProgress: 30,
        ),
        
        const SizedBox(height: 12),

        // Kartu Kedua (Disesuaikan ke .png)
        const ChallengeProgressCard(
          title: "Clean your home",
          imageAsset: 'assets/images/water.png', 
          currentProgress: 5,
          totalProgress: 30,
        ),
      ],
    );
  }
}