import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class SelectableHabitCard extends StatelessWidget {
  final String title;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableHabitCard({
    super.key,
    required this.title,
    required this.emoji,
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
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.habitSelected : Colors.white,
          borderRadius: BorderRadius.circular(30), // Menjadi Kapsul
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
            
            const SizedBox(width: 8),
            
            Text(
              title,
              style: AppTextStyles.habitCardTitle.copyWith(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}