import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/models/progress_model.dart';
import 'package:mino/pages/journal/widgets/monthly_reflection.dart';
import 'package:mino/widgets/dialogs/month_picker_sheet.dart';
import 'package:mino/core/constants/app_colors.dart';

import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/pages/journal/widgets/period_switcher.dart';
import 'package:mino/pages/journal/widgets/goal_card.dart';
import 'package:mino/pages/journal/widgets/activity_card.dart';
import 'package:mino/pages/journal/widgets/weekly_reflection.dart';

// Model Progress dari Backend
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

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  bool _isWeekly = true;
  String? _selectedMonthName;
  late AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animCtrl.forward();

    context.read<DashboardBloc>().add(
      const DashboardEvent.fetchDashboardData(),
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  // 🔥 HELPER FUNCTION: Menyingkat nama bulan dari DB (contoh: September -> Sep)
  String _toShortMonth(String? monthName) {
    if (monthName == null || monthName.isEmpty) return '';
    return monthName.length > 3 ? monthName.substring(0, 3) : monthName;
  }

  void _showMonthPicker(Progress progressData) {
    final List<AllMonth> availableMonths = progressData.allMonths ?? [];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => MonthPickerSheet(
        selectedMonth: _toShortMonth(_selectedMonthName ?? progressData.month),
        // 🔥 Nama bulan di list dropdown otomatis disingkat 3 huruf
        months: availableMonths.map((d) => _toShortMonth(d.name)).toList(),
        onSelected: (monthName) {
          setState(() {
            _selectedMonthName = monthName;
          });
          _animCtrl.forward(from: 0);

          // 🔥 Cari ID berdasarkan nama bulan versi singkat yang cocok
          final selectedMonthObj = availableMonths.firstWhere(
            (m) => _toShortMonth(m.name) == monthName,
            orElse: () => AllMonth(id: null, name: monthName),
          );

          if (selectedMonthObj.id != null) {
            context.read<DashboardBloc>().add(
              DashboardEvent.fetchDashboardData(month: selectedMonthObj.id),
            );
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.orange100),
            ),
          ),
          error: (message) => Scaffold(
            body: Center(
              child: Text(
                'Gagal memuat data: $message',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          success: (response) {
            final progressData = response.dashboard?.progress;

            if (progressData == null) {
              return const Scaffold(
                body: Center(child: Text('Data progress tidak ditemukan')),
              );
            }

            // 🔴 COBA TAMBAHKAN KODE PRINT INI UNTUK DEBUGGING DI CONSOLE
            print("=== CEK DATA PROGRESS MINO ===");
            print("Bulan dari DB: ${progressData.month}");
            print("Persentase Weekly: ${progressData.weeklyGoalPercent}%");
            print("Persentase Monthly: ${progressData.monthlyGoalPercent}%");
            print("Jumlah Bar Weekly: ${progressData.weeklyBars?.length} data");
            print(
              "Jumlah Bar Monthly: ${progressData.monthlyBars?.length} data",
            );
            print("==============================");

            // 🔥 Sinkronisasi Nama Bulan Singkat ke State
            _selectedMonthName = _toShortMonth(progressData.month);

            // 🔥 Normalisasi Angka Persentase agar tidak crash (> 1.0 dibagi 100)
            double rawWeekly = progressData.weeklyGoalPercent ?? 0.0;
            double rawMonthly = progressData.monthlyGoalPercent ?? 0.0;
            double cleanWeeklyPercent = rawWeekly > 1.0
                ? rawWeekly / 100
                : rawWeekly;
            double cleanMonthlyPercent = rawMonthly > 1.0
                ? rawMonthly / 100
                : rawMonthly;

            final activeGoalData = MonthData(
              month: _isWeekly ? 'This Week' : (_selectedMonthName ?? ''),
              goalPercent: _isWeekly ? cleanWeeklyPercent : cleanMonthlyPercent,
              weeklyBars: _isWeekly
                  ? (progressData.weeklyBars ?? [])
                  : (progressData.monthlyBars ?? []),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==========================================
                // 1. BAGIAN ATAS (FIXED / TIDAK IKUT SCROLL)
                // ==========================================
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 32,
                    bottom: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Progress',
                        style: TextStyle(
                          color: AppColors.orange100,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
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

                // ==========================================
                // 2. BAGIAN BAWAH (BISA DI-SCROLL)
                // ==========================================
                Expanded(
                  child: ClipRect(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 26),

                          GoalCard(isWeekly: _isWeekly, data: activeGoalData),
                          const SizedBox(height: 26),

                          ActivityCard(
                            isWeekly: _isWeekly,
                            selectedMonth: _selectedMonthName ?? '',
                            currentProgressData: progressData,
                            onMonthPickerTap: () =>
                                _showMonthPicker(progressData),
                          ),
                          const SizedBox(height: 26),

                          _isWeekly
                              ? const WeeklyReflection()
                              : MonthlyReflection(
                                  selectedMonth: _selectedMonthName ?? '',
                                ),

                          const SizedBox(height: 130),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          orElse: () => const Scaffold(
            body: Center(child: Text('Memulai memuat data...')),
          ),
        );
      },
    );
  }
}
