import 'package:flutter/material.dart';
import 'profile_stat_card.dart';

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 1,
        children: [
          ProfileStatCard(
            icon: Icons.check,
            iconColor: const Color(0xFFE6A84A),
            iconBackgroundColor: const Color(0xFFE6A84A).withOpacity(0.15),
            value: '23',
            label: 'Total Habits',
          ),
          ProfileStatCard(
            icon: Icons.diamond_outlined,
            iconColor: const Color(0xFF3FA7C4),
            iconBackgroundColor: const Color(0xFF3FA7C4).withOpacity(0.15),
            value: '89',
            label: 'Diamonds',
          ),
          ProfileStatCard(
            icon: Icons.timer_outlined,
            iconColor: const Color(0xFFD4D4D4),
            iconBackgroundColor: Colors.white.withOpacity(0.08),
            value: '45',
            label: 'Focus Hours',
          ),
          ProfileStatCard(
            icon: Icons.workspace_premium_outlined,
            iconColor: const Color(0xFFE6A84A),
            iconBackgroundColor: const Color(0xFFE6A84A).withOpacity(0.15),
            value: '8',
            label: 'Challenges',
          ),
        ],
      ),
    );
  }
}