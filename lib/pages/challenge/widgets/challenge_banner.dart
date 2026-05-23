import 'package:flutter/material.dart';

import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class ChallengeBanner extends StatelessWidget {
  final String title;
  final String subtitle;

  const ChallengeBanner({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSizes.xl,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),

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
            color:
                AppColors.orange500.withOpacity(
              0.15,
            ),

            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            title,

            style:
                AppTextStyles.pageTitleBold,
          ),

          const SizedBox(height: AppSizes.sm),

          Text(
            subtitle,

            style: AppTextStyles.secondaryMedium
                .copyWith(
              color: AppColors.orange100,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}