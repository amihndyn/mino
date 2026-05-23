import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class PilihDialog extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String) onSelected;

  const PilihDialog({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
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

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              title,

              style:
                  AppTextStyles.sectionTitleBold,
            ),

            const SizedBox(height: AppSizes.lg),

            ...items.map(
              (item) => GestureDetector(
                onTap: () {
                  onSelected(item);
                  Navigator.pop(context);
                },

                child: Container(
                  width: double.infinity,

                  margin: const EdgeInsets.only(
                    bottom: AppSizes.md,
                  ),

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: AppSizes.lg,
                    vertical: AppSizes.md,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.coklat700,

                    borderRadius:
                        BorderRadius.circular(
                      AppSizes.radiusMd,
                    ),
                  ),

                  child: Text(
                    item,
                    style:
                        AppTextStyles.bodyMedium,
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