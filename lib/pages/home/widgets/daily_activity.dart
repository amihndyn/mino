import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class DailyActivity extends StatelessWidget {
  const DailyActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.md),

      decoration: BoxDecoration(
        color: AppColors.coklat800,

        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Today Activity',
            style: AppTextStyles.sectionTitleBold,
          ),

          const SizedBox(height: AppSizes.lg),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: const [
              _ActivityItem(
                value: '05',
                label: 'Habits',
              ),

              _ActivityItem(
                value: '02',
                label: 'Journal',
              ),

              _ActivityItem(
                value: '87%',
                label: 'Focus',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String value;
  final String label;

  const _ActivityItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.pageTitleBold.copyWith(
            color: AppColors.orange400,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: AppTextStyles.secondaryMedium,
        ),
      ],
    );
  }
}