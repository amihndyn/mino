import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class StatisticsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatisticsCard({
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

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.12,
            ),

            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,

            decoration: BoxDecoration(
              color:
                  AppColors.orange500.withOpacity(
                0.15,
              ),

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