import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import 'package:mino/pages/journal/journal_page.dart';
import 'package:mino/pages/timer/timer_page.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _ActionCard(
            icon: Icons.edit_rounded,
            title: 'Journal',
          ),
        ),

        SizedBox(width: AppSizes.md),

        Expanded(
          child: _ActionCard(
            icon: Icons.timer_rounded,
            title: 'Focus',
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ActionCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'Journal') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const JournalPage(),
            ),
          );
        }

        if (title == 'Focus') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const TimerPage(),
            ),
          );
        }
      },

      child: Container(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        decoration: BoxDecoration(
          color: AppColors.coklat800,

          borderRadius:
              BorderRadius.circular(
            AppSizes.cardRadius,
          ),

          border: Border.all(
            color: AppColors.coklat600,
          ),
        ),

        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,

              decoration: BoxDecoration(
                color: AppColors.orange500
                    .withOpacity(0.15),

                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: AppColors.orange400,
                size: 28,
              ),
            ),

            const SizedBox(
              height: AppSizes.md,
            ),

            Text(
              title,
              style:
                  AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}