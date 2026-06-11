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
        childAspectRatio: 1.05, // ✨ Disesuaikan agar proporsi card pas dengan isi konten
        children: const [
          ProfileStatCard(
            imagePath: 'assets/images/kalender.png', 
            value: '128',
            label: 'Habits Completed',
          ),
          ProfileStatCard(
            imagePath: 'assets/images/kalender.png',
            value: '42H',
            label: 'Focus Hours',
          ),
          ProfileStatCard(
            imagePath: 'assets/images/kalender.png',
            value: '12 days',
            label: 'Challenge',
          ),
          ProfileStatCard(
            imagePath: 'assets/images/kalender.png',
            value: '16',
            label: 'Diamond earned',
          ),
        ],
      ),
    );
  }
}