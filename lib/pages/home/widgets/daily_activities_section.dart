import 'package:flutter/material.dart';

import 'activity_item_card.dart';

class DailyActivitiesSection
    extends StatelessWidget {
  const DailyActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: const [
        Text(
          "Daily Activities",
          style: TextStyle(
            color: Color(0xffE6A84A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 16),

        ActivityItemCard(
          title: "Take a deep breath",
          icon: Icons.air,
        ),

        SizedBox(height: 12),

        ActivityItemCard(
          title: "Smile for a few seconds",
          icon: Icons.emoji_emotions,
        ),

        SizedBox(height: 12),

        ActivityItemCard(
          title: "Fix your posture",
          icon: Icons.accessibility_new,
        ),
      ],
    );
  }
}