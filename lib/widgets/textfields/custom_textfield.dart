import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final int maxLines;
   final bool isPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.maxLines = 1,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,

      style: AppTextStyles.bodyRegular,

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: AppTextStyles.secondaryMedium,

        filled: true,
        fillColor: AppColors.coklat800,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.md,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.radiusLg,
          ),

          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.radiusLg,
          ),

          borderSide: BorderSide(
            color: AppColors.coklat600,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.radiusLg,
          ),

          borderSide: BorderSide(
            color: AppColors.orange400,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}