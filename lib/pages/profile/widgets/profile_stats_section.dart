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
        childAspectRatio: 1.05, // Sedikit disesuaikan agar card tidak terlalu tinggi
        children: const [
          ProfileStatCard(
            imagePath: 'assets/images/kalender.png', // 🛠️ Sesuai request kamu
            label: 'Habits Completed',
            value: '128',
          ),
          ProfileStatCard(
            imagePath: 'assets/images/kalender.png',
            label: 'Focus Hours',
            value: '42H',
          ),
          ProfileStatCard(
            imagePath: 'assets/images/kalender.png',
            label: 'Challenge',
            value: '12 days',
          ),
          ProfileStatCard(
            imagePath: 'assets/images/kalender.png',
            label: 'Diamond earned',
            value: '16',
          ),
        ],
      ),
    );
  }
}