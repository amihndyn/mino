import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String image;

  const ProfileCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.lg),

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
            color: Colors.black.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          // AVATAR
          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              border: Border.all(
                color: AppColors.orange400,
                width: 2,
              ),

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
                  name,
                  style: AppTextStyles.sectionTitleBold,
                ),

                const SizedBox(height: 4),

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
              color: AppColors.orange500.withOpacity(0.12),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.edit_rounded,
              color: AppColors.orange400,
            ),
          ),
        ],
      ),
    );
  }
}