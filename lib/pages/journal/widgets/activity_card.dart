import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart'; // Menggunakan model asli dari backend

class ActivityCard extends StatelessWidget {
  final bool isWeekly;
  final String selectedMonth;
  final Progress? currentProgressData; 
  final VoidCallback onMonthPickerTap;

  const ActivityCard({
    super.key,
    required this.isWeekly,
    required this.selectedMonth,
    required this.currentProgressData,
    required this.onMonthPickerTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Ambil data mentah asli dari properti backend Laravel
    final List<double> rawData = isWeekly
        ? (currentProgressData?.weeklyBars ?? [])
        : (currentProgressData?.monthlyBars ?? []);

    // 🔥 PERBAIKAN UTAMA: Jika data Laravel kosong/null, paksa buat array berisi nilai 0.0 
    // supaya jumlah 'length' terpenuhi, sehingga teks hari dan "Week 1-4" TETAP DI-RENDER.
    final List<double> chartData = rawData.isNotEmpty 
        ? rawData 
        : (isWeekly ? List.filled(7, 0.0) : List.filled(4, 0.0));

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
                              color: Color(0xFFF5E6D3),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isWeekly
                              ? 'Your habit consistency this week'
                              : 'Your habit consistency in $selectedMonth',
                          style: const TextStyle(
                              color: Color(0xFFE6A84A),
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                  if (!isWeekly)
                    GestureDetector(
                      onTap: onMonthPickerTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 9),
                        decoration: BoxDecoration(
                          color: AppColors.coklat800
                              .withAlpha((0.8 * 255).toInt()),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.orange700
                                .withAlpha((0.5 * 255).toInt()),
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
                    ? _buildWeeklyChart(chartData)
                    : _buildMonthlyChart(chartData),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(List<double> weeklyData) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final yAxisLabels = ['100%', '75%', '50%', '25%', '0%'];

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
                      height: (weeklyData[index] * 160).clamp(0.0, 160.0),
                      decoration: const BoxDecoration(
                        color: AppColors.orange800,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(7)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      index < days.length ? days[index] : 'Day ${index + 1}',
                      style: const TextStyle(
                          color: AppColors.orange100, fontSize: 13),
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
    final weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
    final yAxisLabels = ['100%', '75%', '50%', '25%', '0%'];

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
                      width: 45,
                      height: (barData[index] * 160).clamp(0.0, 160.0),
                      decoration: const BoxDecoration(
                        color: AppColors.orange800,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(7)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      index < weeks.length ? weeks[index] : 'Wk ${index + 1}',
                      style: const TextStyle(
                          color: AppColors.orange100, fontSize: 13),
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