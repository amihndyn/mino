import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class MoodCard extends StatelessWidget {
  final String mood;
  final String description;
  final String emoji;

  const MoodCard({
    super.key,
    required this.mood,
    required this.description,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.lg),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            AppColors.coklat700,
            AppColors.coklat900,
          ],
        ),

        border: Border.all(
          color: AppColors.coklat600,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.orange500.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Row(
        children: [
          // EMOJI
          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              color: AppColors.orange500.withOpacity(0.15),
              shape: BoxShape.circle,
            ),

            alignment: Alignment.center,

            child: Text(
              emoji,
              style: const TextStyle(fontSize: 32),
            ),
          ),

          const SizedBox(width: AppSizes.md),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  mood,
                  style: AppTextStyles.sectionTitleBold,
                ),

                const SizedBox(height: 6),

                Text(
                  description,
                  style: AppTextStyles.secondaryMedium.copyWith(
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}