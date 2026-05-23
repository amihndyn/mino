import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class HabitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const HabitCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.md),

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
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [
          // IMAGE
          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              color: AppColors.coklat700,
              borderRadius: BorderRadius.circular(20),

              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: AppSizes.md),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: AppTextStyles.sectionTitleBold,
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: AppTextStyles.secondaryMedium,
                ),
              ],
            ),
          ),

          // ICON
          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: AppColors.orange500.withOpacity(0.15),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.orange400,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}