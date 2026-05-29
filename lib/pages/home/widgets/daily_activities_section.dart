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

        // Menggunakan emoji berupa String agar sama persis dengan tampilan visualnya
        ActivityItemCard(
          title: "Take a deep breath",
          emoji: "📔", 
        ),
        SizedBox(height: 14),

        ActivityItemCard(
          title: "Smile for a few seconds",
          emoji: "😊",
        ),
        SizedBox(height: 14),

        ActivityItemCard(
          title: "Fix your posture",
          emoji: "🧘",
        ),
      ],
    );
  }
}