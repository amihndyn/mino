import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class LoadingWidget extends StatelessWidget {
  final String text;

  const LoadingWidget({
    super.key,
    this.text = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: AppColors.coklat800,
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color: AppColors.orange500
                      .withOpacity(0.12),

                  blurRadius: 25,
                  spreadRadius: 2,
                ),
              ],
            ),

            child: const CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.orange400,
            ),
          ),

          const SizedBox(height: AppSizes.lg),

          Text(
            text,
            style: AppTextStyles.secondaryMedium,
          ),
        ],
      ),
    );
  }
}