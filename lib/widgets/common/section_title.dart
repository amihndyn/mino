import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onTap;

  const SectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: AppTextStyles.sectionTitleBold,
        ),

        if (actionText != null)
          GestureDetector(
            onTap: onTap,

            child: Text(
              actionText!,
              style: AppTextStyles.secondaryMedium
                  .copyWith(
                color: AppColors.orange400,
              ),
            ),
          ),
      ],
    );
  }
}