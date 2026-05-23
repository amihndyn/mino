import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.lg),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSizes.radiusLg,
        ),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            AppColors.coklat700,
            AppColors.coklat900,
          ],
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.orange500.withOpacity(0.12),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Good Evening ✨',
            style: AppTextStyles.pageTitleBold,
          ),

          const SizedBox(height: AppSizes.sm),

          Text(
            'Ready to improve yourself today?',
            style: AppTextStyles.secondaryMedium,
          ),

          const SizedBox(height: AppSizes.lg),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: AppColors.orange500.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Text(
                  '7 Days Streak 🔥',
                  style: AppTextStyles.secondaryMedium.copyWith(
                    color: AppColors.orange300,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}