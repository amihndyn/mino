import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/models/progress_model.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/dialogs/month_picker_sheet.dart';

import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/pages/journal/widgets/period_switcher.dart';
import 'package:mino/pages/journal/widgets/goal_card.dart';
import 'package:mino/pages/journal/widgets/activity_card.dart';
import 'package:mino/pages/journal/widgets/stats_grid.dart';
import 'package:mino/pages/journal/widgets/weekly_achievements.dart';
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
      children: [
        const CustomAppBar(title: 'Progress'),
        Expanded(
          // 1. Tambahkan ClipRect di sini juga
          child: ClipRect(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.md),
                  JournalTabSwitch(
                    selectedIndex: widget.currentTabIndex,
                    onChanged: widget.onTabChanged,
                  ),
                  const SizedBox(height: 26),
                  PeriodSwitcher(
                    isWeekly: _isWeekly,
                    onChanged: (val) => setState(() => _isWeekly = val),
                  ),
                  const SizedBox(height: 26),
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
                  const StatsGrid(),
                  const SizedBox(height: 26),
                  const WeeklyAchievements(),
                  const SizedBox(height: 26),
                  const WeeklyReflection(),
                  // 2. Diubah menjadi 130 agar konsisten dengan halaman Journal
                  const SizedBox(height: 130), 
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}