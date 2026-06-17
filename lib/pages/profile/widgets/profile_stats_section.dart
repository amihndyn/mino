import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart'; 
import 'profile_stat_card.dart';

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Pantau state dari DashboardBloc
    final dashboardState = context.watch<DashboardBloc>().state;

    // 2. Siapkan variabel default jika data belum termuat
    String habitsCompleted = '0';
    String focusHours      = '0';
    String challengeDays   = '0';
    String diamondEarned   = '0';

    // 3. Ekstrak data berdasarkan struktur JSON DashboardResponseModel asli
    dashboardState.maybeWhen(
      success: (response) {
        final dashboardData = response.dashboard;
        if (dashboardData != null) {
          // A. HITUNG HABITS COMPLETED TODAY
          // Menghitung berapa banyak habit yang 'isCompletedToday == true' dari list todayHabits
          final completedCount = dashboardData.todayHabits?.where((h) => h.isCompletedToday == true).length ?? 0;
          habitsCompleted = '$completedCount';

          // B. KONVERSI FOCUS MINUTES KE HOURS
          // Karena dari API bentuknya menit (focusMinutesToday), kita bagi 60 agar menjadi jam
          final rawMinutes = dashboardData.summary?.focusMinutesToday ?? 0;
          if (rawMinutes > 0) {
            double hours = rawMinutes / 60;
            // Jika hasilnya bulat (misal 2.0), tampilkan "2H". Jika desimal, batasi 1 angka di belakang koma (misal 1.5H)
            focusHours = hours % 1 == 0 ? '${hours.toInt()}h' : '${hours.toStringAsFixed(1)}h';
          } else {
            focusHours = '0h';
          }

          // C. AMBIL STREAK HABIT TERBERSAR (CHALLENGE)
          // Mencari angka streak tertinggi dari daftar habit hari ini
          int maxStreak = 0;
          if (dashboardData.todayHabits != null && dashboardData.todayHabits!.isNotEmpty) {
            for (var habit in dashboardData.todayHabits!) {
              if ((habit.streak ?? 0) > maxStreak) {
                maxStreak = habit.streak!;
              }
            }
          }
          challengeDays = '$maxStreak days';

          // D. AMBIL DIAMOND USER
          diamondEarned = '${dashboardData.user?.diamonds ?? 0}';
        }
      },
      orElse: () {
        // Fallback otomatis menggunakan nilai '0' saat loading / error
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.count(
        padding: const EdgeInsets.only(top: 12, bottom: 16),
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 1.05,
        children: [
          ProfileStatCard(
            imagePath: 'assets/images/ini.png', 
            label: 'Habits Completed',
            value: habitsCompleted, 
          ),
          ProfileStatCard(
            imagePath: 'assets/images/piala.png',
            label: 'Focus Hours',
            value: focusHours, 
          ),
          ProfileStatCard(
            imagePath: 'assets/images/centang.png',
            label: 'Challenge',
            value: challengeDays, 
          ),
          ProfileStatCard(
            imagePath: 'assets/images/biru.png',
            label: 'Diamond earned',
            value: diamondEarned, 
          ),
        ],
      ),
    );
  }
}