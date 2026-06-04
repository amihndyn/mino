import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/models/progress_model.dart';

class ActivityCard extends StatelessWidget {
  final bool isWeekly;
  final String selectedMonth;
  final MonthData? currentMonthData;
  final VoidCallback onMonthPickerTap;

  const ActivityCard({
    super.key,
    required this.isWeekly,
    required this.selectedMonth,
    required this.currentMonthData,
    required this.onMonthPickerTap,
  });

  @override
  Widget build(BuildContext context) {
    final weeklyData = [2.2, 1.8, 0.9, 2.0, 1.5, 2.2, 2.2];

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.coklat900.withAlpha((0.35 * 255).toInt()),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: AppColors.orange700.withAlpha((0.3 * 255).toInt()),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isWeekly ? 'Weekly Activity' : 'Monthly Activity',
                          style: const TextStyle(
                            color: AppColors.orange100,
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isWeekly
                              ? 'Your habit consistency\nthis week'
                              : 'Your habit consistency\nin $selectedMonth',
                          style: const TextStyle(
                            color: AppColors.orange800,
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isWeekly)
                    GestureDetector(
                      onTap: onMonthPickerTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.coklat800.withAlpha((0.8 * 255).toInt()),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.orange700.withAlpha((0.5 * 255).toInt()),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedMonth,
                              style: const TextStyle(
                                color: AppColors.orange100,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.orange300,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 220,
                child: isWeekly
                    ? _buildWeeklyChart(weeklyData)
                    : _buildMonthlyChart(currentMonthData!.weeklyBars),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(List<double> weeklyData) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
    final yAxisLabels = ['4', '3', '2', '1', '0'];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: yAxisLabels.map((label) {
              return Text(
                label,
                style: const TextStyle(
                  color: AppColors.coklat300,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                weeklyData.length,
                (index) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 28,
                      height: weeklyData[index] * 40,
                      decoration: const BoxDecoration(
                        color: AppColors.orange800,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      days[index],
                      style: const TextStyle(color: AppColors.orange100, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChart(List<double> barData) {
    final days = ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6', 'Week 7'];
    final yAxisLabels = ['4', '3', '2', '1', '0'];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: yAxisLabels.map((label) {
              return Text(
                label,
                style: const TextStyle(
                  color: AppColors.coklat300,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                barData.length,
                (index) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 50,
                      height: barData[index] * 40,
                      decoration: const BoxDecoration(
                        color: AppColors.orange800,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      days[index],
                      style: const TextStyle(color: AppColors.orange100, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}