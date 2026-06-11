import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/models/progress_model.dart'; // Tetap biarkan jika MonthData masih dipakai di tempat lain
import 'package:mino/pages/journal/widgets/monthly_reflection.dart';
import 'package:mino/widgets/dialogs/month_picker_sheet.dart';
import 'package:mino/core/constants/app_colors.dart';

import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/pages/journal/widgets/period_switcher.dart';
import 'package:mino/pages/journal/widgets/goal_card.dart';
import 'package:mino/pages/journal/widgets/activity_card.dart';
import 'package:mino/pages/journal/widgets/weekly_reflection.dart';

// 🔥 IMPORT MODEL PROGRESS BARU KAMU DI SINI
import 'package:mino/core/data/model/response/dashboard_response.dart'; 

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

  // 🔥 1. Ubah List Dummy menggunakan objek Progress asli dari backend
  final List<Progress> _monthlyData = [
    Progress(
      month: 'May 2026', 
      weeklyGoalPercent: 0.84, 
      monthlyGoalPercent: 0.84, 
      weeklyBars: [3.2, 2.8, 3.5, 2.0],
      monthlyBars: [3.2, 2.8, 3.5, 2.0], // Diisi dummy data samakan saja dulu
    ),
    Progress(
      month: 'April 2026', 
      weeklyGoalPercent: 0.72, 
      monthlyGoalPercent: 0.72, 
      weeklyBars: [2.5, 3.0, 2.8, 3.2],
      monthlyBars: [2.5, 3.0, 2.8, 3.2],
    ),
    Progress(
      month: 'March 2026', 
      weeklyGoalPercent: 0.65, 
      monthlyGoalPercent: 0.65, 
      weeklyBars: [2.0, 2.2, 2.5, 2.8],
      monthlyBars: [2.0, 2.2, 2.5, 2.8],
    ),
  ];

  late AnimationController _animCtrl;

  // 🔥 2. Kembalian fungsi getter ini sekarang bertipe Progress
  Progress get _currentMonthData => _monthlyData.firstWhere(
        (d) => d.month == _selectedMonth,
        orElse: () => _monthlyData.first,
      );

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
        months: _monthlyData.map((d) => d.month ?? '').toList(),
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
    // 🔥 3. Bungkus activeGoalData lama ke format MonthData demi GoalCard (karena GoalCard masih pakai model lama)
    final activeGoalData = MonthData(
      month: _isWeekly ? 'This Week' : _currentMonthData.month ?? '',
      goalPercent: _isWeekly 
          ? (_currentMonthData.weeklyGoalPercent ?? 0.0) 
          : (_currentMonthData.monthlyGoalPercent ?? 0.0),
      weeklyBars: _currentMonthData.weeklyBars ?? [],
    );

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
                  const SizedBox(height: 26), 
                  
                  GoalCard(
                    isWeekly: _isWeekly,
                    data: activeGoalData,
                  ),
                  const SizedBox(height: 26),
                  
                  // 🔥 4. SEKARANG SUDAH PAS DENGAN PARAMETER BARU DI ACTIVITYCARD
                  ActivityCard(
                    isWeekly: _isWeekly,
                    selectedMonth: _selectedMonth,
                    currentProgressData: _currentMonthData, // Mengirim objek Progress, bukan MonthData
                    onMonthPickerTap: _showMonthPicker,
                  ),
                  const SizedBox(height: 26),
                  
                  // 🔥 LOGIC SAUSAN: Tampilkan Reflection sesuai tipe (Weekly / Monthly)
                  _isWeekly 
                      ? const WeeklyReflection() 
                      : MonthlyReflection(selectedMonth: _selectedMonth),
                  
                  // 🔥 UI AMI: Jarak aman untuk bottom navbar
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