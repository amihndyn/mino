import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class MoodEmoji extends StatelessWidget {
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodEmoji({
    super.key,
    required this.emoji,
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

        width: 72,
        height: 72,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color: isSelected
              ? AppColors.orange500
                  .withOpacity(0.18)
              : AppColors.coklat800,

          border: Border.all(
            color: isSelected
                ? AppColors.orange400
                : AppColors.coklat600,

            width: 1.5,
          ),

          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.orange500
                        .withOpacity(0.12),

                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),

        alignment: Alignment.center,

        child: Text(
          emoji,
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}