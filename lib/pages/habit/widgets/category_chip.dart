import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 250,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.lg,
          vertical: AppSizes.sm,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.orange500
                  .withOpacity(0.15)
              : AppColors.coklat800,

          borderRadius: BorderRadius.circular(
            30,
          ),

          border: Border.all(
            color: isSelected
                ? AppColors.orange400
                : AppColors.coklat600,
          ),
        ),

        child: Text(
          title,

          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected
                ? AppColors.orange300
                : AppColors.orange100,
          ),
        ),
      ),
    );
  }
}