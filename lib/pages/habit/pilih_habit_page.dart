import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
import 'package:mino/widgets/button/custom_button.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/habit_provider.dart';

import 'widgets/add_habit_header.dart';
import 'widgets/habit_section.dart';
import 'widgets/unique_habit_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';

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
                /// 1. Background Image (Diubah ke SVG)
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/bg_login.png',
                    fit: BoxFit.cover,
                  ),
                ),

                /// 2. Content (Scrollable)
                SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 14,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color:
                                AppColors.orange100, // Warna solid base konten
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          child: SingleChildScrollView(
                            // Padding ekstra di bawah agar konten terakhir tidak tertutup tombol
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 24,
                              bottom: 120,
                            ),
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
                                  style: AppTextStyles.sectionTitleBold
                                      .copyWith(color: AppColors.coklat700),
                                ),

                                const SizedBox(height: 12),

                                const UniqueHabitCard(),

                                const SizedBox(height: 32),

                                /// HABIT SECTIONS DENGAN VALIDASI DUPLIKASI
                                ...provider.sections.entries.map(
                                  (section) => Padding(
                                    padding: const EdgeInsets.only(bottom: 28),
                                    child: HabitSection(
                                      title: section.key,
                                      habits: section.value,
                                      selectedHabits: provider.selectedHabits,
                                      onSelect: (value) {
                                        // 🔥 LANGKAH 1: Ambil data dashboard saat ini dari DashboardBloc
                                        final dashboardState = context
                                            .read<DashboardBloc>()
                                            .state;
                                        List<String> currentHabitNames = [];

                                        dashboardState.maybeWhen(
                                          success: (response) {
                                            // Kumpulkan semua nama habit yang sudah nampang di halaman utama hari ini
                                            currentHabitNames =
                                                response.dashboard?.todayHabits
                                                    ?.map(
                                                      (h) => h.habitName ?? '',
                                                    )
                                                    .where(
                                                      (name) => name.isNotEmpty,
                                                    )
                                                    .toList() ??
                                                [];
                                          },
                                          orElse: () {},
                                        );

                                        // 🔥 LANGKAH 2: Validasi pencegahan duplikasi nama habit template
                                        // Jika status habit sudah dipilih sebelumnya (ingin membatalkan pilihan/uncheck), loloskan validasi
                                        if (provider.selectedHabits.contains(
                                          value,
                                        )) {
                                          provider.toggleHabit(value);
                                        } else if (provider
                                            .isHabitAlreadyExists(
                                              value,
                                              currentHabitNames,
                                            )) {
                                          // ❌ Jika sudah ada di Dashboard, munculkan peringatan SnackBar
                                          ScaffoldMessenger.of(
                                            context,
                                          ).clearSnackBars(); // Bersihkan snackbar lama agar tidak menumpuk
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Habit "$value" sudah terdaftar di Dashboard hari ini!',
                                              ),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        } else {
                                          // ✅ Jika belum ada di Dashboard, masukkan ke list pilihan
                                          provider.toggleHabit(value);
                                        }
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

                /// 3. FLOATING BUTTON dengan efek Fade/Solid Background
                if (provider.selectedHabits.isNotEmpty)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      // Gunakan gradient untuk transisi halus, menutupi item list di belakangnya
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.orange100.withOpacity(
                              0.0,
                            ), // Transparan di atas
                            AppColors.orange100.withOpacity(0.8),
                            AppColors.orange100, // Solid di bawah
                            AppColors.orange100, // Pastikan benar-benar solid
                          ],
                          stops: const [0.0, 0.2, 0.5, 1.0],
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 32, // Jarak ekstra di atas tombol untuk efek fade
                        bottom: 34,
                      ),
                      child: SafeArea(
                        top: false,
                        child: CustomButton(
                          text: "Add Selected Habits",
                          onTap: () {
                            // 1. Ambil daftar habit yang dicentang
                            final selectedList = provider.selectedHabits;

                            // 2. Looping: Kirim setiap nama habit ke Laravel via BLoC
                            for (String habitName in selectedList) {
                              context.read<DashboardBloc>().add(
                                DashboardEvent.addHabit(habitName),
                              );
                            }

                            // 3. Tampilkan pesan sukses
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${selectedList.length} Habit berhasil ditambahkan!',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // 4. Kembali ke halaman Dashboard Utama
                            Navigator.pop(context);
                          },
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
