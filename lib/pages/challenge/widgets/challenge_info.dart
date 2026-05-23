import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class ChallengeInfo extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ChallengeInfo({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
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

      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: AppColors.orange500
                  .withOpacity(0.12),

              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: AppColors.orange400,
            ),
          ),

          const SizedBox(width: AppSizes.md),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style:
                      AppTextStyles.secondaryMedium,
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style:
                      AppTextStyles.sectionTitleBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}