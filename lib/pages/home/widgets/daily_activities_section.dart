import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/habit/edit_uniqur_habit_page.dart';
import 'package:mino/pages/home/widgets/activity_item_card.dart';
import 'package:mino/pages/habit/widgets/delete_habit_dialog.dart';
import 'package:provider/provider.dart';
import 'package:mino/providers/habit_provider.dart'; // Sesuaikan path provider-mu ya!

class DailyActivitiesSection extends StatelessWidget {
  final List<dynamic> habits; // Data berupa list of TodayHabit dari API

  const DailyActivitiesSection({
    super.key,
    required this.habits,
  });

  // Fungsi pembantu perpindahan ke halaman Edit
  void _handleEdit(BuildContext context, dynamic habitItem) async {
    final String currentTitle = habitItem.habitName ?? '';
    final int habitId = habitItem.userHabitId ?? 0;

    // Buka halaman EditHabitPage dan tunggu user menekan tombol "Save"
    final updatedTitle = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => EditHabitPage(habitName: currentTitle),
      ),
    );

    // Jika user menekan Save dan namanya berubah, kirim ke BLoC / API!
    if (updatedTitle != null && updatedTitle != currentTitle && context.mounted) {
      debugPrint("Kirim edit ke server! Nama baru: $updatedTitle");
      
      // 🔥 AKTIFKAN EVENT BLOC UNTUK EDIT:
      context.read<DashboardBloc>().add(DashboardEvent.editHabit(habitId, updatedTitle));
    }
  }

  // Fungsi pembantu menampilkan pop-up konfirmasi hapus
  void _handleDelete(BuildContext context, dynamic habitItem) async {
    final String currentTitle = habitItem.habitName ?? '';
    final int habitId = habitItem.userHabitId ?? 0;

    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const DeleteHabitDialog(),
    );

    if (confirmDelete == true && context.mounted) {
      // 🔥 AKTIFKAN: Kirim event hapus data ke BLoC
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
          
          // 🔥 PERBAIKAN IKON DINAMIS: 
          // 1. Tanya ke HabitProvider, "Eh, habit dengan nama ini path gambarnya apa?"
          final String? iconPath = context.read<HabitProvider>().getIconPath(title);
          
          // 2. Jika ketemu, pakai gambar itu. Jika null (Custom), pakai gambar Bintang!
          final String assetPath = iconPath ?? 'assets/images/stars.png'; 

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ActivityItemCard(
              title: title,
              imageAsset: assetPath, // Kirim path gambar yang sudah dinamis ke Card
              isCompleted: isCompleted,
              onToggle: () {
                // 🔥 PERBAIKAN UTAMA: Sekarang mengirimkan id dan status boolean-nya saat ini (isCompleted)
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
        }).toList(),
      ],
    );
  }
}