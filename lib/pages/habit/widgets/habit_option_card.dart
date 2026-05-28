import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HabitOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const HabitOptionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.orange300
              : AppColors.orange100,

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: isSelected
                ? AppColors.orange700
                : Colors.transparent,
            width: 1.5,
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                color: AppColors.coklat600,
              ),
            ),

            const SizedBox(width: 10),

            Flexible(
              child: Text(
                title,
                style:
                    AppTextStyles.secondaryMedium
                        .copyWith(
                  color: AppColors.coklat700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}