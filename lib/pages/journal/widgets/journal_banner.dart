import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';

class JournalBanner extends StatelessWidget {
  final String monthYear;

  const JournalBanner({
    super.key,
    required this.monthYear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange900.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/img_jurnal.png',
            fit: BoxFit.cover,
          ),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.coklat900.withValues(alpha: 0.9),
                  AppColors.coklat900.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Inner glow border
          Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.cardRadius - 2),
              border: Border.all(
                color: AppColors.orange700.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.lg,
              vertical: AppSizes.md,
            ),
            child: Row(
              children: [
                // Text content
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        monthYear,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange100,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: AppColors.orange500.withValues(alpha: 0.6),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),

                    ],
                  ),
                ),

                // Decorative icon

              ],
            ),
          ),
        ],
      ),
    );
  }
}