import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/models/progress_model.dart';

class WeeklyAchievements extends StatelessWidget {
  const WeeklyAchievements({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      AchievementData(emoji: '🎯', title: 'Focus Master'),
      AchievementData(emoji: '🌤️', title: 'Early Riser'),
      AchievementData(emoji: '💎', title: 'Consistency\nMiner'),
      AchievementData(emoji: '⛏️', title: 'Deep Worker'),
    ];

    const double gap = 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weekly Achievements',
          style: TextStyle(
            color: AppColors.orange100,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = (constraints.maxWidth - (2 * gap)) / 2.25;
            final double cardHeight = cardWidth;

            return SizedBox(
              height: cardHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: achievements.length,
                separatorBuilder: (_, __) => const SizedBox(width: gap),
                itemBuilder: (context, index) {
                  final item = achievements[index];
                  return Container(
                    width: cardWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.coklat900,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: Colors.blue.withAlpha((0.5 * 255).toInt()),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            item.emoji,
                            style: const TextStyle(fontSize: 42),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.coklat300.withAlpha((0.9 * 255).toInt()),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}