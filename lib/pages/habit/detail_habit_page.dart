import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import '../../widgets/cards/habit_card.dart';

import 'widgets/habit_progress.dart';

class DetailHabitPage extends StatelessWidget {
  const DetailHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            HabitCard(
              title: 'Morning Run',
              subtitle:
                  'Run 5km every morning',
              image:
                  'assets/images/run.png',
            ),

            const SizedBox(height: AppSizes.xl),

            const HabitProgress(
              title: 'Weekly Progress',
              progress: 0.7,
            ),

            const SizedBox(height: AppSizes.xl),

            Text(
              'Description',

              style:
                  AppTextStyles.sectionTitleBold,
            ),

            const SizedBox(height: AppSizes.md),

            Text(
              'Build a healthy morning routine by running every day for at least 5 kilometers.',

              style: AppTextStyles
                  .secondaryMedium
                  .copyWith(
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}