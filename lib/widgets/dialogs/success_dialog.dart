import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,

      child: Container(
        padding: const EdgeInsets.all(
          AppSizes.xl,
        ),

        decoration: BoxDecoration(
          color: AppColors.coklat800,

          borderRadius: BorderRadius.circular(
            AppSizes.radiusLg,
          ),

          border: Border.all(
            color: AppColors.coklat600,
          ),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            // ICON
            Container(
              width: 80,
              height: 80,

              decoration: BoxDecoration(
                color: AppColors.orange500
                    .withOpacity(0.15),

                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.check_rounded,
                color: AppColors.orange400,
                size: 42,
              ),
            ),

            const SizedBox(height: AppSizes.lg),

            // TITLE
            Text(
              title,
              textAlign: TextAlign.center,

              style:
                  AppTextStyles.sectionTitleBold,
            ),

            const SizedBox(height: AppSizes.sm),

            // SUBTITLE
            Text(
              subtitle,
              textAlign: TextAlign.center,

              style: AppTextStyles.secondaryMedium
                  .copyWith(
                height: 1.5,
              ),
            ),

            const SizedBox(height: AppSizes.xl),

            // BUTTON
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },

              child: Container(
                width: double.infinity,
                height: 55,

                decoration: BoxDecoration(
                  color: AppColors.orange500,

                  borderRadius:
                      BorderRadius.circular(
                    AppSizes.radiusLg,
                  ),
                ),

                alignment: Alignment.center,

                child: Text(
                  'Continue',

                  style: AppTextStyles.bodyMedium
                      .copyWith(
                    color: AppColors.coklat900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}