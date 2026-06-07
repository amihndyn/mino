import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/models/progress_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GoalCard extends StatelessWidget {
  final bool isWeekly;
  final MonthData data;

  const GoalCard({
    super.key,
    required this.isWeekly,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final percentLabel = '${(data.goalPercent * 100).toInt()}%';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange700.withAlpha((0.15 * 255).toInt()),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.coklat900.withAlpha((0.35 * 255).toInt()),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: AppColors.orange900.withAlpha((0.35 * 255).toInt()),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isWeekly ? 'Weekly Goal' : 'Monthly Goal',
                        style: const TextStyle(
                          color: Color(0xFFF5E6D3),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "You're getting\ncloser to your\ndiamond.",
                        style: TextStyle(
                          color: Color(0xFFE6A84A),
                          fontSize: 20,
                          height: 1.3,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 42,
                  lineWidth: 8,
                  percent: data.goalPercent,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: AppColors.orange300,
                  backgroundColor: AppColors.orange900.withAlpha((0.25 * 255).toInt()),
                  center: Text(
                    percentLabel,
                    style: const TextStyle(
                      color: AppColors.orange700,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}