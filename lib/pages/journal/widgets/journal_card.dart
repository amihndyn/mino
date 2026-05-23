import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class JournalCard extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final VoidCallback? onTap;

  const JournalCard({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,

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

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.12,
              ),

              blurRadius: 14,
              offset: const Offset(0, 6),
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
                  AppTextStyles.sectionTitleBold,
            ),

            const SizedBox(height: AppSizes.sm),

            Text(
              content,

              maxLines: 3,
              overflow: TextOverflow.ellipsis,

              style:
                  AppTextStyles.secondaryMedium
                      .copyWith(
                height: 1.6,
              ),
            ),

            const SizedBox(height: AppSizes.lg),

            Align(
              alignment: Alignment.centerRight,

              child: Text(
                date,

                style:
                    AppTextStyles.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}