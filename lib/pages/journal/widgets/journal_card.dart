import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class JournalCard extends StatelessWidget {
  final String dayName;
  final int dayNumber;
  final String moodLabel;
  final String moodEmoji;
  final Color moodColor;
  final VoidCallback? onSeeNote;

  const JournalCard({
    super.key,
    required this.dayName,
    required this.dayNumber,
    required this.moodLabel,
    required this.moodEmoji,
    this.moodColor = AppColors.orange400,
    this.onSeeNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.coklat800,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(
          color: AppColors.orange900.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange900.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — day name + number
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.md,
              AppSizes.md,
              AppSizes.md,
              AppSizes.sm,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$dayName  ',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.coklat200,
                    fontSize: 13,
                  ),
                ),
                Text(
                  '$dayNumber',
                  style: AppTextStyles.displayBold.copyWith(
                    fontSize: 28,
                    color: AppColors.orange100,
                  ),
                ),
              ],
            ),
          ),

          // Mood box
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
              decoration: BoxDecoration(
                color: AppColors.coklat700,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mood',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.orange300,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(moodEmoji, style: const TextStyle(fontSize: 40)),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    moodLabel,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: moodColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // See my note button
          Padding(
            padding: const EdgeInsets.all(AppSizes.sm),
            child: GestureDetector(
              onTap: onSeeNote,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.sm,
                  horizontal: AppSizes.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.coklat700,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  border: Border.all(color: AppColors.coklat500, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'See my note',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.coklat200,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.coklat200,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
