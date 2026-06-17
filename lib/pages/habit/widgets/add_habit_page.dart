import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Pastikan diimport untuk pakai BlocListener
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/providers/habit_provider.dart';
import 'package:provider/provider.dart';

// Import file Anda
import 'add_habit_header.dart';
import 'habit_section.dart';
import '../../../core/constants/app_colors.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca state dari HabitProvider
    final habitProvider = Provider.of<HabitProvider>(context);
    final sections = habitProvider.sections;

    // 🔥 KITA BUNGKUS DENGAN BLOCLISTENER DI SINI
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        // Mendengarkan saat state dashboard berubah ke 'success'
        state.maybeWhen(
          success: (response) {
            // Ketika backend Laravel sukses merespons & data terupdate,
            // kita bersihkan daftar checklist di provider, lalu tutup halaman.
            if (context.mounted) {
              habitProvider.selectedHabits.clear(); // Opsional: reset list setelah sukses
              Navigator.pop(context);
            }
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.black,

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddHabitHeader(),
                const SizedBox(height: 24),

                // Melakukan perulangan otomatis untuk semua section yang ada di Provider
                ...sections.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: HabitSection(
                      title: entry.key,
                      habits: entry.value,
                      selectedHabits: habitProvider.selectedHabits, // Oper List-nya
                      onSelect: (value) {
                        habitProvider.toggleHabit(value); // Panggil fungsi toggle
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),

        // ===== BAGIAN TOMBOL MUNCUL JIKA ADA YANG DIPILIH =====
        bottomNavigationBar: habitProvider.selectedHabits.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9F2), // Samakan dengan background
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Ambil daftar nama habit yang dicentang oleh user
                    final List<String> selectedHabits = habitProvider.selectedHabits;

                    // 🔥 LOOPING: Kirim semua habit yang dicentang satu per satu ke BLoC & Laravel
                    for (var habitName in selectedHabits) {
                      context.read<DashboardBloc>().add(
                            DashboardEvent.addHabit(habitName),
                          );
                    }

                    // ❌ DIUBAH: Navigator.pop(context) di sini diapus!
                    // Biarkan BlocListener di atas yang bertugas menutup halaman saat data sukses masuk.
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "${habitProvider.selectedHabits.length} Habit Selected",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(), // Jika kosong, hilangkan tombol (SizedBox.shrink)
      ),
    );
  }
}