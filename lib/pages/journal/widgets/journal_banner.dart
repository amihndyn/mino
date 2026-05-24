import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class JournalBanner extends StatelessWidget {
  final String monthYear;

  const JournalBanner({super.key, required this.monthYear});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(
          color: AppColors.orange900.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange900.withValues(alpha: 0.2),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),

          // Dark overlay gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.coklat900.withValues(alpha: 0.85),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Month label
          Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                monthYear,
                style: AppTextStyles.sectionTitleBold.copyWith(
                  fontSize: 20,
                  color: AppColors.orange100,
                  shadows: [
                    Shadow(
                      color: AppColors.orange500.withValues(alpha: 0.6),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
