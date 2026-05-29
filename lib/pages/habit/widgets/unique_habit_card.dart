import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

import '../create_unique_habit_page.dart';

class UniqueHabitCard extends StatelessWidget {
  const UniqueHabitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const CreateUniqueHabitPage(),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: AppColors.orange200,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,

              decoration: BoxDecoration(
                color: AppColors.orange100,
                borderRadius: BorderRadius.circular(14),
              ),

              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.coklat700,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                "Create a unique habit",
                style:
                    AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.coklat700,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.coklat500,
            ),
          ],
        ),
      ),
    );
  }
}