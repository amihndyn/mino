import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import '../../widgets/appbars/custom_appbar.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: const CustomAppBar(
        title: 'Focus Timer',
        showBackButton: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),

        child: Column(
          children: [
            const Spacer(),

            // TIMER CIRCLE
            Container(
              width: 260,
              height: 260,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    AppColors.orange700,
                    AppColors.coklat700,
                  ],
                ),

                boxShadow: [
                  BoxShadow(
                    color: AppColors.orange500
                        .withOpacity(0.18),

                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ],
              ),

              child: Center(
                child: Text(
                  '25:00',

                  style:
                      AppTextStyles.displayBold.copyWith(
                    fontSize: 52,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.xl),

            Text(
              'Stay focused and productive ✨',

              style: AppTextStyles.secondaryMedium,
            ),

            const Spacer(),

            // BUTTONS
            Row(
              children: [
                Expanded(
                  child: _TimerButton(
                    title: 'Start',
                    isPrimary: true,
                  ),
                ),

                const SizedBox(width: AppSizes.md),

                Expanded(
                  child: _TimerButton(
                    title: 'Reset',
                    isPrimary: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerButton extends StatelessWidget {
  final String title;
  final bool isPrimary;

  const _TimerButton({
    required this.title,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}