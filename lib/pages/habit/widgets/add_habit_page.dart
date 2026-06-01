import 'package:flutter/material.dart';
import 'package:mino/providers/habit_provider.dart';
import 'package:provider/provider.dart'; // Jangan lupa import provider

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

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F2),
      
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
                  )
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Lakukan aksi di sini, contoh: nge-print data yang dipilih
                  print("Habit yang dipilih: ${habitProvider.selectedHabits}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange700, // Warna button kustom
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  // Menampilkan jumlah yang dipilih
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
    );
  }
}