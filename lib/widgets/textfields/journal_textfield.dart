import 'package:flutter/material.dart';

import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class JournalTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  const JournalTextField({
    super.key,
    this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.coklat800,

        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),

        border: Border.all(
          color: AppColors.coklat600,
        ),
      ),

      child: TextField(
        controller: controller,
        maxLines: 10,

        style: AppTextStyles.bodyRegular,

        decoration: InputDecoration(
          hintText: hintText,

          hintStyle: AppTextStyles.secondaryMedium,

          contentPadding: const EdgeInsets.all(
            AppSizes.lg,
          ),

          border: InputBorder.none,
        ),
      ),
    );
  }
}