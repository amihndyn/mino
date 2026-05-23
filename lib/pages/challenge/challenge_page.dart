import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';

import '../../widgets/appbars/custom_appbar.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/cards/challenge_card.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: const CustomAppBar(
        title: 'Challenges',
        showBackButton: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lg),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SectionTitle(
              title: 'Active Challenge',
            ),

            const SizedBox(height: AppSizes.lg),

            const ChallengeCard(
              title: '7 Days Focus Challenge',
              subtitle:
                  'Stay productive and focused everyday ✨',

              progress: 0.7,
            ),

            const SizedBox(height: AppSizes.xl),

            const SectionTitle(
              title: 'Recommended',
            ),

            const SizedBox(height: AppSizes.lg),

            const ChallengeCard(
              title: 'Morning Routine',
              subtitle:
                  'Build healthy habits every morning 🌞',

              progress: 0.3,
            ),

            const SizedBox(height: AppSizes.md),

            const ChallengeCard(
              title: 'Reading Challenge',
              subtitle:
                  'Read at least 10 pages everyday 📚',

              progress: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}