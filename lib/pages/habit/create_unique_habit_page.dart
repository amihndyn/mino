import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_text_styles.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/habit/widgets/create_habit_card.dart';
import 'package:mino/pages/home/home_page.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── 🔥 IMPORT TEMPLATE POPUP KAMU DENGAN BENAR ──
import 'package:mino/widgets/popUp/pop_up_berhasil.dart';
import 'package:mino/widgets/popUp/pop_up_gagal.dart';

class CreateUniqueHabitPage extends StatefulWidget {
  const CreateUniqueHabitPage({super.key});

  @override
  State<CreateUniqueHabitPage> createState() => _CreateUniqueHabitPageState();
}

class _CreateUniqueHabitPageState extends State<CreateUniqueHabitPage> {
  final TextEditingController habitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    habitController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    habitController.removeListener(_onTextChanged);
    habitController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

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
        final tween = Tween<Offset>(
          begin: const Offset(0, -1),
          end: const Offset(0, 0),
        );

        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Material(color: Colors.transparent, child: child),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // ── 🔥 GUNAKAN BLOCLISTENER UNTUK DETEKSI BERHASIL / GAGAL ──
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (response) {
              // 🎉 POPUP BERHASIL MELUNCUR
              _showTopNotification(
                context,
                PopUpBerhasil(
                  message: "Custom habit berhasil dibuat!",
                  onClose: () => Navigator.of(context).pop(),
                ),
              );
              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomePage(), // 🔥 GANTI 'HomePage()' dengan nama Class Halaman Utamamu jika berbeda
                    ),
                    (route) =>
                        false, // Menghapus total riwayat page lama agar tidak bisa di-back
                  );
                }
              });
            },
            error: (message) {
              // ❌ POPUP GAGAL MELUNCUR
              _showTopNotification(
                context,
                PopUpGagal(
                  message: message ?? "Gagal membuat habit. Silakan coba lagi.",
                  onClose: () => Navigator.of(context).pop(),
                ),
              );
            },
            orElse: () {},
          );
        },
        child: Stack(
          children: [
            /// BACKGROUND UTAMA
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_login.png',
                fit: BoxFit.cover,
              ),
            ),

            /// KONTEN UTAMA
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const Spacer(flex: 1),

                  Expanded(
                    flex: 14,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.orange100,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: [
                          /// HEADER: Title & Cancel Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Create a unique habit",
                                style: AppTextStyles.habitSectionTitle,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  "Cancel",
                                  style: AppTextStyles.secondaryMedium.copyWith(
                                    color: const Color(0xFFA7A7A7),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          /// INPUT FIELD CARD
                          CreateHabitCard(controller: habitController),

                          const Spacer(),

                          /// TOMBOL SAVE (Kondisional)
                          if (habitController.text.trim().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CustomButton(
                                text: "Save",
                                onTap: () {
                                  final String uniqueName = habitController.text
                                      .trim();

                                  // Kirim event penambahan habit ke BLoC
                                  context.read<DashboardBloc>().add(
                                    DashboardEvent.addHabit(uniqueName),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
