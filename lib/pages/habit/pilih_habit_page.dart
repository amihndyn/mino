import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/habit_provider.dart';

import 'widgets/add_habit_header.dart';
import 'widgets/habit_section.dart';
import 'widgets/unique_habit_card.dart';

class PilihHabitPage extends StatelessWidget {
  const PilihHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HabitProvider(),
      child: Consumer<HabitProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Stack(
              children: [
                /// 1. Background
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/bg_login.png',
                    fit: BoxFit.cover,
                  ),
                ),

                /// 2. Content (Scrollable)
                SafeArea(
                  bottom: false, // Biar container orange mentok sampai bawah layar
                  child: Column(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 14,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 24,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.orange100,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          child: SingleChildScrollView(
                            // Beri padding bawah ekstra agar konten paling bawah tidak tertutup oleh tombol melayang
                            padding: const EdgeInsets.only(bottom: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// HEADER
                                const AddHabitHeader(),

                                const SizedBox(height: 28),

                                /// TITLE
                                Text(
                                  "Let's discovery your new habits",
                                  style: AppTextStyles.pageTitleBold.copyWith(
                                    color: AppColors.coklat700,
                                    height: 1.2,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                /// SUBTITLE
                                Text(
                                  "Choose one habit, then tap Next",
                                  style: AppTextStyles.bodyRegular.copyWith(
                                    color: AppColors.coklat500,
                                  ),
                                ),

                                const SizedBox(height: 30),

                                /// UNIQUE HABIT
                                Text(
                                  "Be unique",
                                  style: AppTextStyles.sectionTitleBold.copyWith(
                                    color: AppColors.coklat700,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                const UniqueHabitCard(),

                                const SizedBox(height: 32),

                                /// HABIT SECTIONS
                                ...provider.sections.entries.map(
                                  (section) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 28,
                                    ),
                                    child: HabitSection(
                                      title: section.key,
                                      habits: section.value,
                                      selectedHabits: provider.selectedHabits,
                                      onSelect: (value) {
                                        provider.toggleHabit(value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 3. FLOATING BUTTON (Persis Sesuai Desain)
                if (provider.selectedHabits.isNotEmpty)
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 34, // Mengambang pas di atas area home indicator HP
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () {
                          print("Pilihan: ${provider.selectedHabits}");
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            // Warna cokelat gelap/charcoal mewah sesuai desain gambar
                            color: const Color(0xFF33221C), 
                            borderRadius: BorderRadius.circular(30), // Bentuk Kapsul/Pill
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              )
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Habit selected",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}