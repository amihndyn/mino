import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class HabitProgress extends StatelessWidget {
  final String title;
  final double progress;

  const HabitProgress({
    super.key,
    required this.title,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppSizes.lg,
      ),

      decoration: BoxDecoration(
        color: AppColors.coklat800,

        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),

        border: Border.all(
          color: AppColors.coklat600,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Text(
                title,
                style:
                    AppTextStyles.sectionTitleBold,
              ),

              Text(
                '${(progress * 100).toInt()}%',

                style: AppTextStyles.bodyMedium
                    .copyWith(
                  color: AppColors.orange400,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.md),

          ClipRRect(
            borderRadius: BorderRadius.circular(
              20,
            ),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,

              backgroundColor:
                  AppColors.coklat700,

              valueColor:
                  const AlwaysStoppedAnimation(
                AppColors.orange400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}