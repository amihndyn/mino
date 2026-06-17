import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart'; // Impor model TodayHabit
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/habit/edit_uniqur_habit_page.dart';
import 'package:mino/pages/home/widgets/activity_item_card.dart';
import 'package:mino/pages/habit/widgets/delete_habit_dialog.dart';
import 'package:provider/provider.dart';
import 'package:mino/providers/habit_provider.dart';

class DailyActivitiesSection extends StatelessWidget {
  // 🟢 PERBAIKAN 1: Gunakan tipe data spesifik TodayHabit agar autocompletion aman
  final List<TodayHabit> habits; 

  const DailyActivitiesSection({
    super.key,
    required this.habits,
  });

  // Fungsi pembantu perpindahan ke halaman Edit
  void _handleEdit(BuildContext context, TodayHabit habitItem) async {
    final String currentTitle = habitItem.habitName ?? '';
    final int habitId = habitItem.userHabitId ?? 0;

    // 🟢 PERBAIKAN 2: Sesuaikan parameter EditHabitPage dengan parameter aslinya (butuh habitId)
    final updatedTitle = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EditHabitPage(
          habitId: habitId,
          habitName: currentTitle,
        ),
      ),
    );

    // Jika proses edit berhasil (return true), trigger ambil data terbaru dari server
    if (updatedTitle == true && context.mounted) {
      context.read<DashboardBloc>().add(const DashboardEvent.fetchDashboardData());
    }
  }

  // Fungsi pembantu menampilkan pop-up konfirmasi hapus
  void _handleDelete(BuildContext context, TodayHabit habitItem) async {
    final int habitId = habitItem.userHabitId ?? 0;

    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const DeleteHabitDialog(),
    );

    if (confirmDelete == true && context.mounted) {
      // Pastikan event deleteHabit sudah terdaftar di Bloc kamu, atau panggil repository eksternal
      context.read<DashboardBloc>().add(DashboardEvent.deleteHabit(habitId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Daily Activities",
          style: TextStyle(
            color: AppColors.orange300,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),

        if (habits.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text(
              "No daily activities set for today.",
              style: TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ),

        ...habits.map((item) {
          final String title = item.habitName ?? 'No Title';
          final bool isCompleted = item.isCompletedToday ?? false;
          
          // Ambil path ikon dari provider
          final String? iconPath = context.read<HabitProvider>().getIconPath(title);
          final String assetPath = iconPath ?? 'assets/images/stars.png'; 

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ActivityItemCard(
              title: title,
              imageAsset: assetPath,
              isCompleted: isCompleted,
              onToggle: () {
                // 🟢 PERBAIKAN 3: Pengaman mounted ditambahkan sebelum mengeksekusi BLoC
                if (!context.mounted) return;

                context.read<DashboardBloc>().add(
                      DashboardEvent.toggleHabit(
                        item.userHabitId ?? 0, 
                        isCompleted,
                      ),
                    );
              },
              onEdit: () => _handleEdit(context, item),
              onDelete: () => _handleDelete(context, item),
            ),
          );
        }), // 🟢 .toList() dihapus karena spread operator (...) otomatis mengekstrak elemen Iterable ke dalam kluster Column children
      ],
    );
  }
}