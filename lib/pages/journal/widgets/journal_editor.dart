import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class JournalEditor extends StatelessWidget {
  final TextEditingController controller;

  const JournalEditor({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 300,
      ),

      padding: const EdgeInsets.all(
        AppSizes.lg,
      ),

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
        maxLines: null,

        style: AppTextStyles.bodyRegular.copyWith(
          height: 1.7,
        ),

        decoration: InputDecoration(
          hintText:
              'Write your feelings and thoughts here...',

          hintStyle:
              AppTextStyles.secondaryMedium,

          border: InputBorder.none,
        ),
      ),
    );
  }
}