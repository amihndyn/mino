import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class TimerButton extends StatelessWidget {
  final String title;
  final bool isPrimary;
  final VoidCallback onTap;

  const TimerButton({
    super.key,
    required this.title,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 56,

        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.orange500
              : AppColors.coklat800,

          borderRadius: BorderRadius.circular(
            AppSizes.radiusLg,
          ),

          border: Border.all(
            color: AppColors.coklat600,
          ),
        ),

        alignment: Alignment.center,

        child: Text(
          title,

          style: AppTextStyles.bodyMedium.copyWith(
            color: isPrimary
                ? AppColors.coklat900
                : AppColors.orange100,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}