import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/pages/habit/edit_uniqur_habit_page.dart';
import 'package:mino/pages/home/widgets/activity_item_card.dart';

// IMPORT FILE EDIT DAN DIALOG YANG SUDAH KITA PISAH TADI (PILIHAN A)
import 'package:mino/pages/habit/widgets/delete_habit_dialog.dart';

class DailyActivitiesSection extends StatelessWidget {
  const DailyActivitiesSection({super.key});

  // Fungsi pembantu untuk menangani perpindahan ke halaman Edit
  void _handleEdit(BuildContext context, String habitName) async {
    final updatedTitle = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => EditHabitPage(habitName: habitName),
      ),
    );

    if (updatedTitle != null) {
      debugPrint("Berhasil Edit! Nama baru: $updatedTitle");
      // TODO: Sinkronisasikan perubahan nama ini ke state / database kamu
    }
  }

  // Fungsi pembantu untuk menampilkan pop-up konfirmasi hapus
  void _handleDelete(BuildContext context, String habitName) async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // User wajib klik tombol di dalam dialog
      builder: (context) => const DeleteHabitDialog(),
    );

    if (confirmDelete == true) {
      debugPrint("Berhasil Hapus! Habit '$habitName' telah dihapus.");
      // TODO: Jalankan fungsi untuk menghapus data dari list kamu di sini
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color titleColor = Color(0xffF2CD94);

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

        // CARD 1: Take a deep breath
        ActivityItemCard(
          title: "Take a deep breath",
          imageAsset: 'assets/images/book.png',
          onEdit: () => _handleEdit(context, "Take a deep breath"),
          onDelete: () => _handleDelete(context, "Take a deep breath"),
        ),
        const SizedBox(height: 14),

        // CARD 2: Smile for a few seconds
        ActivityItemCard(
          title: "Smile for a few seconds",
          imageAsset: 'assets/images/smile.png',
          onEdit: () => _handleEdit(context, "Smile for a few seconds"),
          onDelete: () => _handleDelete(context, "Smile for a few seconds"),
        ),
        const SizedBox(height: 14),

        // CARD 3: Fix your posture
        ActivityItemCard(
          title: "Fix your posture",
          imageAsset: 'assets/images/exercise.png',
          onEdit: () => _handleEdit(context, "Fix your posture"),
          onDelete: () => _handleDelete(context, "Fix your posture"),
        ),
      ],
    );
  }
}