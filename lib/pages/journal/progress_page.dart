import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/models/progress_model.dart';
import 'package:mino/pages/journal/widgets/monthly_reflection.dart';
import 'package:mino/widgets/dialogs/month_picker_sheet.dart';
import 'package:mino/core/constants/app_colors.dart';

import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/pages/journal/widgets/period_switcher.dart';
import 'package:mino/pages/journal/widgets/goal_card.dart';
import 'package:mino/pages/journal/widgets/activity_card.dart';
import 'package:mino/pages/journal/widgets/weekly_reflection.dart';

class ProgressPage extends StatefulWidget {
  final int currentTabIndex;
  final ValueChanged<int> onTabChanged;

  const ProgressPage({
    super.key,
    required this.currentTabIndex,
    required this.onTabChanged,
  });

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> with SingleTickerProviderStateMixin {
  bool _isWeekly = true;
  String _selectedMonth = 'May 2026';

  final List<MonthData> _monthlyData = [
    MonthData(month: 'May 2026', goalPercent: 0.84, weeklyBars: [3.2, 2.8, 3.5, 2.0]),
    MonthData(month: 'April 2026', goalPercent: 0.72, weeklyBars: [2.5, 3.0, 2.8, 3.2]),
    MonthData(month: 'March 2026', goalPercent: 0.65, weeklyBars: [2.0, 2.2, 2.5, 2.8]),
    MonthData(month: 'February 2026', goalPercent: 0.50, weeklyBars: [1.5, 2.0, 2.2, 2.5]),
    MonthData(month: 'January 2026', goalPercent: 0.45, weeklyBars: [1.0, 1.2, 1.5, 1.8]),
    MonthData(month: 'December 2025', goalPercent: 0.30, weeklyBars: [0.8, 1.0, 1.2, 1.5]),
  ];

  late AnimationController _animCtrl;

  MonthData get _currentMonthData => _monthlyData.firstWhere((d) => d.month == _selectedMonth);

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
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
      builder: (_) => MonthPickerSheet(
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
    final activeGoalData = _isWeekly
        ? MonthData(month: 'This Week', goalPercent: 0.84, weeklyBars: [])
        : _currentMonthData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. BAGIAN ATAS (FIXED / TIDAK IKUT SCROLL)
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 32, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Progress',
                style: TextStyle(
                  color: AppColors.orange100,
                  fontSize: 28, 
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1
                ),
              ),
              const SizedBox(height: AppSizes.md),
              
              JournalTabSwitch(
                selectedIndex: widget.currentTabIndex,
                onChanged: widget.onTabChanged,
              ),
              const SizedBox(height: 26),
              
              // Period Switcher diturunkan ke sini agar tidak ikut ke-scroll
              PeriodSwitcher(
                isWeekly: _isWeekly,
                onChanged: (val) => setState(() => _isWeekly = val),
              ),
            ],
          ),
        ),

        // 2. BAGIAN BAWAH (BISA DI-SCROLL)
        Expanded(
          child: ClipRect(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26), // Jarak atas sebelum GoalCard
                  
                  GoalCard(
                    isWeekly: _isWeekly,
                    data: activeGoalData,
                  ),
                  const SizedBox(height: 26),
                  
                  ActivityCard(
                    isWeekly: _isWeekly,
                    selectedMonth: _selectedMonth,
                    currentMonthData: _currentMonthData,
                    onMonthPickerTap: _showMonthPicker,
                  ),
                  const SizedBox(height: 26),
                  
                  const SizedBox(height: 130), // Jarak aman untuk bottom navbar
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}