import 'package:flutter/material.dart';

import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onDelete;

  const DeleteDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onDelete,
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
                color: Colors.red.withOpacity(0.12),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
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

            Row(
              children: [
                // CANCEL
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: Container(
                      height: 55,

                      decoration: BoxDecoration(
                        color: AppColors.coklat700,

                        borderRadius:
                            BorderRadius.circular(
                          AppSizes.radiusLg,
                        ),
                      ),

                      alignment: Alignment.center,

                      child: Text(
                        'Cancel',

                        style:
                            AppTextStyles.bodyMedium,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: AppSizes.md),

                // DELETE
                Expanded(
                  child: GestureDetector(
                    onTap: onDelete,

                    child: Container(
                      height: 55,

                      decoration: BoxDecoration(
                        color: Colors.redAccent,

                        borderRadius:
                            BorderRadius.circular(
                          AppSizes.radiusLg,
                        ),
                      ),

                      alignment: Alignment.center,

                      child: Text(
                        'Delete',

                        style: AppTextStyles.bodyMedium
                            .copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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