import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.lg),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            AppColors.orange800,
            AppColors.coklat700,
          ],
        ),

        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.orange500.withOpacity(0.15),
            blurRadius: 25,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // TITLE
          Text(
            title,
            style: AppTextStyles.sectionTitleBold,
          ),

          const SizedBox(height: AppSizes.sm),

          // SUBTITLE
          Text(
            subtitle,
            style: AppTextStyles.secondaryMedium.copyWith(
              color: AppColors.orange100,
            ),
          ),

          const SizedBox(height: AppSizes.lg),

          // PROGRESS BAR
          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,

              backgroundColor:
                  Colors.white.withOpacity(0.15),

              valueColor: const AlwaysStoppedAnimation(
                AppColors.orange300,
              ),
            ),
          ),

          const SizedBox(height: AppSizes.sm),

          Align(
            alignment: Alignment.centerRight,

            child: Text(
              '${(progress * 100).toInt()}%',
              style: AppTextStyles.secondaryMedium.copyWith(
                color: AppColors.orange100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}