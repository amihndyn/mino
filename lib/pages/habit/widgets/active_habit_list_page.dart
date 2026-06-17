import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/habit/widgets/habit_item_widget.dart';
import 'package:mino/pages/habit/widgets/habit_progress_card.dart';
import 'package:mino/pages/timer/timer_page.dart';
import 'package:mino/providers/habit_provider.dart';
// ── IMPORT POPUP CONFIRMATION GLOBAL ──
import 'package:mino/widgets/popUp/pop_up_info.dart';

class ActiveHabitListPage extends StatelessWidget {
  const ActiveHabitListPage({super.key});

  // 🔥 DIUBAH: Sekarang menggunakan PopUpConfirmation dan menerima parameter title habit
  void _showDeleteDialog(BuildContext pageContext, String title, VoidCallback onDelete) {
    showDialog(
      context: pageContext,
      builder: (BuildContext dialogContext) {
        return PopUpConfirmation(
          title: 'Delete Habit?',
          description: 'The progress for "$title" cannot\nbe recovered once deleted. 💎',
          leftButtonText: 'Cancel',
          rightButtonText: 'Delete',
          topIcon: const Icon(
            Icons.warning_rounded,
            color: Color(0xFFE6A84A),
            size: 44,
          ),
          onLeftTap: () => Navigator.pop(dialogContext),
          onRightTap: () {
            Navigator.pop(dialogContext);
            onDelete(); // Menjalankan fungsi hapus aksi dari BLOC
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // APP BAR CUSTOM
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Today's habit",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // KONTEN UTAMA SINKRON DENGAN BLOC
                Expanded(
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
                        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
                        error: (message) => Center(
                          child: Text(
                            "Gagal memuat data:\n$message",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        success: (response) {
                          final dashboardData = response.dashboard;
                          final summary = dashboardData?.summary;
                          final rawHabits = dashboardData?.todayHabits ?? [];
                          final habits = List.from(rawHabits);

                          // PROSES SORTING HABIT
                          habits.sort((a, b) {
                            final aDone = a.isCompletedToday ?? false;
                            final bDone = b.isCompletedToday ?? false;
                            if (!aDone && bDone) return -1;
                            if (aDone && !bDone) return 1;
                            return 0;
                          });

                          final int completed = summary?.habitsCompletedToday ?? 0;
                          final int total = summary?.habitsTotal ?? 0;
                          final int diamonds = dashboardData?.user?.diamonds ?? 0;

                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HabitProgressCard(
                                  completed: completed,
                                  total: total,
                                  diamonds: diamonds,
                                ),
                                const SizedBox(height: 32),
                                const Text(
                                  'The overall habit',
                                  style: TextStyle(color: AppColors.orange100, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                if (habits.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text('No habits for today.', style: TextStyle(color: Colors.white60)),
                                    ),
                                  )
                                else
                                  ...habits.map((habit) {
                                    final String currentHabitName = habit.habitName ?? 'No Title';
                                    final bool isCompletedToday = habit.isCompletedToday ?? false;
                                    final int habitId = habit.userHabitId ?? 0;
                                    final String? iconPath = context.read<HabitProvider>().getIconPath(currentHabitName);

                                    return HabitItemWidget(
                                      habitId: habitId,
                                      pageContext: context,
                                      iconPath: iconPath,
                                      title: currentHabitName,
                                      isCompleted: isCompletedToday,
                                      onCheckTap: () {
                                        if (habit.userHabitId != null) {
                                          context.read<DashboardBloc>().add(
                                                DashboardEvent.toggleHabit(habitId, isCompletedToday),
                                              );
                                        }
                                      },
                                      onTimerTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TimerPage(
                                              habitId: habitId,
                                              habitName: currentHabitName,
                                            ),
                                          ),
                                        );
                                      },
                                      onEditSuccess: (isSuccess) {
                                        if (isSuccess == true) {
                                          context.read<DashboardBloc>().add(
                                                const DashboardEvent.fetchDashboardData(),
                                              );
                                        }
                                      },
                                      onDelete: () {
                                        _showDeleteDialog(context, currentHabitName, () {
                                          context.read<DashboardBloc>().add(
                                                DashboardEvent.deleteHabit(habitId),
                                              );
                                          context.read<DashboardBloc>().add(
                                                const DashboardEvent.fetchDashboardData(),
                                              );
                                        });
                                      },
                                    );
                                  }).toList(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}