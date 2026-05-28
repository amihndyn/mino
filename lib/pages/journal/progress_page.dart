// ============================================
// PROGRESS PAGE
// ============================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 1; // Start with "Progress" selected
  bool _isWeekly = true;
  String _selectedMonth = 'May 2026';

  final List<_MonthData> _monthlyData = [
    _MonthData(month: 'May 2026', goalPercent: 0.84, weeklyBars: [3.2, 2.8, 3.5, 2.0]),
    _MonthData(month: 'April 2026', goalPercent: 0.72, weeklyBars: [2.5, 3.0, 2.8, 3.2]),
    _MonthData(month: 'March 2026', goalPercent: 0.65, weeklyBars: [2.0, 2.2, 2.5, 2.8]),
    _MonthData(month: 'February 2026', goalPercent: 0.50, weeklyBars: [1.5, 2.0, 2.2, 2.5]),
    _MonthData(month: 'January 2026', goalPercent: 0.45, weeklyBars: [1.0, 1.2, 1.5, 1.8]),
    _MonthData(month: 'December 2025', goalPercent: 0.30, weeklyBars: [0.8, 1.0, 1.2, 1.5]),
  ];

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  _MonthData get _currentMonthData =>
      _monthlyData.firstWhere((d) => d.month == _selectedMonth);

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _MonthPickerSheet(
        selectedMonth: _selectedMonth,
        months: _monthlyData.map((d) => d.month).toList(),
        onSelected: (month) {
          setState(() => _selectedMonth = month);
          _animCtrl.forward(from: 0);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // BACKGROUND
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // CONTENT
          SafeArea(
            child: Column(
              children: [
                // APPBAR
                CustomAppBar(
                  title: 'Progress',
                  actions: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: AppColors.orange200,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // SCROLLABLE CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSizes.md),

                        // JOURNAL / PROGRESS TAB SWITCH
                        JournalTabSwitch(
                          selectedIndex: _tabIndex,
                          onChanged: (index) {
                            if (index == 0) {
                              Navigator.pop(context);
                            } else {
                              setState(() => _tabIndex = index);
                            }
                          },
                        ),

                        const SizedBox(height: 26),

                        // WEEKLY / MONTHLY SWITCHER
                        _buildPeriodSwitcher(),

                        const SizedBox(height: 26),

                        // GOAL CARD
                        _buildGoalCard(),

                        const SizedBox(height: 26),

                        // ACTIVITY CARD
                        _buildActivityCard(),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSwitcher() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isWeekly = true),
                child: Column(
                  children: [
                    Text(
                      'Weekly',
                      style: TextStyle(
                        color: _isWeekly
                            ? AppColors.orange100
                            : AppColors.coklat300,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      color: _isWeekly ? AppColors.orange500 : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _isWeekly = false),
                child: Column(
                  children: [
                    Text(
                      'Monthly',
                      style: TextStyle(
                        color: !_isWeekly
                            ? AppColors.orange100
                            : AppColors.coklat300,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      color: !_isWeekly ? AppColors.orange500 : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(height: 1, color: AppColors.coklat600),
      ],
    );
  }

  Widget _buildGoalCard() {
    final data = _isWeekly
        ? _MonthData(month: 'This Week', goalPercent: 0.84, weeklyBars: [])
        : _currentMonthData;
    final percentLabel = '${(data.goalPercent * 100).toInt()}%';

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.coklat900.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.orange700.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isWeekly ? 'Weekly Goal' : 'Monthly Goal',
                      style: TextStyle(
                        color: AppColors.coklat300,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "You're getting\ncloser to your\ndiamond.",
                      style: TextStyle(
                        color: AppColors.orange200,
                        fontSize: 18,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
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
                backgroundColor: AppColors.orange900.withValues(alpha: 0.25),
                center: Text(
                  percentLabel,
                  style: TextStyle(
                    color: AppColors.orange300,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard() {
    final weeklyData = [2.2, 1.8, 0.9, 2.0, 1.5, 2.2, 2.2];
    final data = _isWeekly ? null : _currentMonthData;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.coklat900.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: AppColors.orange700.withValues(alpha: 0.3),
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
                          _isWeekly ? 'Weekly Activity' : 'Monthly Activity',
                          style: TextStyle(
                            color: AppColors.orange100,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isWeekly
                              ? 'Your habit consistency\nthis week'
                              : 'Your habit consistency\nin $_selectedMonth',
                          style: TextStyle(
                            color: AppColors.orange600,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // MONTH DROPDOWN (only for Monthly view)
                  if (!_isWeekly)
                    GestureDetector(
                      onTap: _showMonthPicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.coklat800.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.orange700.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _selectedMonth,
                              style: TextStyle(
                                color: AppColors.orange100,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
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
                child: _isWeekly
                    ? _buildWeeklyChart(weeklyData)
                    : _buildMonthlyChart(data!.weeklyBars),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(List<double> weeklyData) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
    return Row(
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
              decoration: BoxDecoration(
                color: AppColors.orange700,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              days[index],
              style: TextStyle(color: AppColors.orange100, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyChart(List<double> barData) {
    final labels = ['week 1', 'week 2', 'week 3', 'week 4'];
    final maxValue = 4.0;

    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              barData.length,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: (barData[index] / maxValue).clamp(0.05, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.orange500,
                              AppColors.orange700,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: labels
              .map((l) => Expanded(
                    child: Text(
                      l,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.orange100,
                        fontSize: 11,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

// =========================================
// MONTH DATA MODEL
// =========================================

class _MonthData {
  final String month;
  final double goalPercent;
  final List<double> weeklyBars;

  _MonthData({
    required this.month,
    required this.goalPercent,
    required this.weeklyBars,
  });
}

// =========================================
// MONTH PICKER SHEET
// =========================================

class _MonthPickerSheet extends StatelessWidget {
  final String selectedMonth;
  final List<String> months;
  final Function(String) onSelected;

  const _MonthPickerSheet({
    required this.selectedMonth,
    required this.months,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.coklat900,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.orange700.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.coklat600,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Pilih Bulan',
            style: TextStyle(
              color: AppColors.orange100,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: months.length,
            itemBuilder: (_, i) {
              final month = months[i];
              final isSel = month == selectedMonth;
              return GestureDetector(
                onTap: () => onSelected(month),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isSel
                        ? AppColors.orange700
                        : AppColors.coklat800.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSel
                          ? AppColors.orange400
                          : AppColors.orange700.withValues(alpha: 0.3),
                      width: isSel ? 1.5 : 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    month.split(' ').first,
                    style: TextStyle(
                      color: isSel
                          ? AppColors.orange100
                          : AppColors.coklat300,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}