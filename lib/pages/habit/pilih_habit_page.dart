import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

// ── 🔥 IMPORT TEMPLATE POPUP KAMU DENGAN BENAR ──
import 'package:mino/widgets/popUp/pop_up_berhasil.dart'; 
import 'package:mino/widgets/popUp/pop_up_gagal.dart';    

class PilihHabitPage extends StatelessWidget {
  const PilihHabitPage({super.key});

  // ── 🛠️ WIDGET HELPER: ANIMASI SLIDE DOWN DARI ATAS LAYAR ──
  void _showTopNotification(BuildContext context, Widget child) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.2), 
      transitionDuration: const Duration(milliseconds: 400), 
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, widgetChild) {
        final tween = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0));
        
        return SlideTransition(
          position: tween.animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutBack)),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Material(
                  color: Colors.transparent,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HabitProvider(),
      child: Consumer<HabitProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Stack(
              children: [
                /// 1. Background Image
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
                            color: AppColors.orange100, 
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          child: SingleChildScrollView(
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
                                        final dashboardState = context
                                            .read<DashboardBloc>()
                                            .state;
                                        List<String> currentHabitNames = [];

                                        dashboardState.maybeWhen(
                                          success: (response) {
                                            currentHabitNames = response
                                                    .dashboard?.todayHabits
                                                    ?.map((h) => h.habitName ?? '')
                                                    .where((name) => name.isNotEmpty)
                                                    .toList() ?? [];
                                          },
                                          orElse: () {},
                                        );

                                        if (provider.selectedHabits.contains(value)) {
                                          provider.toggleHabit(value);
                                        } else if (provider.isHabitAlreadyExists(
                                          value,
                                          currentHabitNames,
                                        )) {
                                          // ❌ KONDISI GAGAL: PopUpGagal Bahasa Inggris
                                          _showTopNotification(
                                            context,
                                            PopUpGagal(
                                              message: 'Habit "$value" is already on your Dashboard today!',
                                              onClose: () => Navigator.of(context).pop(),
                                            ),
                                          );

                                          // Hilang sendiri dalam 1.5 detik
                                          Future.delayed(const Duration(milliseconds: 1500), () {
                                            if (context.mounted) {
                                              Navigator.of(context).pop();
                                            }
                                          });

                                        } else {
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
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.orange100.withOpacity(0.0), 
                            AppColors.orange100.withOpacity(0.8),
                            AppColors.orange100, 
                            AppColors.orange100, 
                          ],
                          stops: const [0.0, 0.2, 0.5, 1.0],
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 32, 
                        bottom: 34,
                      ),
                      child: SafeArea(
                        top: false,
                        child: CustomButton(
                          text: "Add Selected Habits",
                          onTap: () {
                            final selectedList = provider.selectedHabits;

                            // Kirim data ke Laravel via BLoC
                            for (String habitName in selectedList) {
                              context.read<DashboardBloc>().add(
                                    DashboardEvent.addHabit(habitName),
                                  );
                            }

                            // 🎉 KONDISI BERHASIL: PopUpBerhasil Bahasa Inggris
                            _showTopNotification(
                              context,
                              PopUpBerhasil(
                                message: '${selectedList.length} successfully added!',
                                onClose: () => Navigator.of(context).pop(),
                              ),
                            );

                            // Jeda 1.5 detik (1500ms) lalu popup hilang dan balik ke Dashboard
                            Future.delayed(const Duration(milliseconds: 1500), () {
                              if (context.mounted) {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context); // Tutup top alert popup
                                }
                                Navigator.pop(context); // Balik ke Dashboard utama
                              }
                            });
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