import 'package:flutter/material.dart';
import 'activity_item_card.dart';

class DailyActivitiesSection extends StatelessWidget {
  const DailyActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna teks judul sesuai dengan tema emas/krem di atasnya
    const Color titleColor = Color(0xffF2CD94);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Daily Activities",
          style: TextStyle(
            color: titleColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 16),

        // Kartu Pertama (Diubah ke .svg)
        ActivityItemCard(
          title: "Take a deep breath",
          imageAsset: 'assets/images/book.svg',
        ),
        SizedBox(height: 14),

        // Kartu Kedua (Diubah ke .svg)
        ActivityItemCard(
          title: "Smile for a few seconds",
          imageAsset: 'assets/images/smile.svg',
        ),
        SizedBox(height: 14),

        // Kartu Ketiga (Diubah ke .svg)
        ActivityItemCard(
          title: "Fix your posture",
          imageAsset: 'assets/images/exercise.svg',
        ),
      ],
    );
  }
}