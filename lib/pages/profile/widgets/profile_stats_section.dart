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
        physics:
            const NeverScrollableScrollPhysics(),

        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 1,

        children: [

          ProfileStatCard(
            icon: Icons.check,
            iconColor: Color(0xFFE6A84A),
            value: '23',
            label: 'Total Habits',
          ),

          ProfileStatCard(
            icon: Icons.diamond_outlined,
            iconColor: Color(0xFF3FA7C4),
            value: '89',
            label: 'Diamonds',
          ),

          ProfileStatCard(
            icon:
                Icons.local_fire_department_outlined,
            iconColor: Color(0xFFFF7A00),
            value: '12',
            label: 'Best Streak',
          ),

          ProfileStatCard(
            icon:
                Icons.workspace_premium_outlined,
            iconColor: Color(0xFFE6A84A),
            value: '5',
            label: 'Challenges',
          ),
        ],
      ),
    );
  }
}