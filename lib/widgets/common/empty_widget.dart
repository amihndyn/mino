import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const EmptyWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSizes.xl,
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width: 90,
              height: 90,

              decoration: BoxDecoration(
                color: AppColors.coklat800,
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: AppColors.orange400,
                size: 40,
              ),
            ),

            const SizedBox(height: AppSizes.lg),

            Text(
              title,
              textAlign: TextAlign.center,

              style:
                  AppTextStyles.sectionTitleBold,
            ),

            const SizedBox(height: AppSizes.sm),

            Text(
              subtitle,
              textAlign: TextAlign.center,

              style: AppTextStyles.secondaryMedium
                  .copyWith(
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}