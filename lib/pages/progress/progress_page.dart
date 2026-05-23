import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import '../../widgets/appbars/custom_appbar.dart';
import '../../widgets/common/section_title.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: const CustomAppBar(
        title: 'Your Progress',
        showBackButton: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lg),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SectionTitle(
              title: 'Weekly Statistics',
            ),

            const SizedBox(height: AppSizes.lg),

            // CHART CARD
            Container(
              width: double.infinity,
              height: 220,

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

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    'Habit Completion',

                    style:
                        AppTextStyles.sectionTitleBold,
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    crossAxisAlignment:
                        CrossAxisAlignment.end,

                    children: const [
                      _Bar(height: 70),
                      _Bar(height: 110),
                      _Bar(height: 85),
                      _Bar(height: 140),
                      _Bar(height: 120),
                      _Bar(height: 160),
                      _Bar(height: 130),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.xl),

            const SectionTitle(
              title: 'Today Result',
            ),

            const SizedBox(height: AppSizes.lg),

            Row(
              children: const [
                Expanded(
                  child: _StatisticsCard(
                    value: '87%',
                    label: 'Focus',
                  ),
                ),

                SizedBox(width: AppSizes.md),

                Expanded(
                  child: _StatisticsCard(
                    value: '5/6',
                    label: 'Habits',
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

class _Bar extends StatelessWidget {
  final double height;

  const _Bar({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: height,

      decoration: BoxDecoration(
        color: AppColors.orange500,

        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _StatisticsCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatisticsCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),

      decoration: BoxDecoration(
        color: AppColors.coklat800,

        borderRadius: BorderRadius.circular(
          AppSizes.cardRadius,
        ),

        border: Border.all(
          color: AppColors.coklat600,
        ),
      ),

      child: Column(
        children: [
          Text(
            value,

            style:
                AppTextStyles.pageTitleBold.copyWith(
              color: AppColors.orange400,
            ),
          ),

          const SizedBox(height: AppSizes.sm),

          Text(
            label,
            style: AppTextStyles.secondaryMedium,
          ),
        ],
      ),
    );
  }
}