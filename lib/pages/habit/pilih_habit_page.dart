import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';

import '../../widgets/appbars/custom_appbar.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/cards/habit_card.dart';

class PilihHabitPage extends StatelessWidget {
  const PilihHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: const CustomAppBar(
        title: 'Your Habits',
        showBackButton: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lg),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SectionTitle(
              title: 'Daily Habits',
            ),

            const SizedBox(height: AppSizes.lg),

            HabitCard(
              title: 'Morning Routine',
              subtitle:
                  'Start your day with positive energy',

              image: 'assets/images/habit1.jpg',
            ),

            const SizedBox(height: AppSizes.md),

            HabitCard(
              title: 'Drink Water',
              subtitle:
                  'Stay hydrated throughout the day',

              image: 'assets/images/habit2.jpg',
            ),

            const SizedBox(height: AppSizes.md),

            HabitCard(
              title: 'Read Book',
              subtitle:
                  'Build knowledge little by little',

              image: 'assets/images/habit3.jpg',
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange500,

        onPressed: () {},

        child: const Icon(
          Icons.add_rounded,
          color: AppColors.coklat900,
        ),
      ),
    );
  }
}