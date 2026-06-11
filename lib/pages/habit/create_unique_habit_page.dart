import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_text_styles.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';
import 'package:mino/pages/habit/widgets/create_habit_card.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:provider/provider.dart';

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
    // Pasang listener agar UI me-render ulang setiap kali user mengetik sesuatu
    habitController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Bersihkan listener saat halaman ditutup
    habitController.removeListener(_onTextChanged);
    habitController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {}); // Memicu build ulang untuk cek kondisi tombol Save
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND UTAMA (Bagian gelap di atas - Diubah ke SVG)
          Positioned.fill(
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          /// KONTEN UTAMA
          SafeArea(
            bottom:
                false, // Memastikan warna cream container bawah mentok hingga akhir layar
            child: Column(
              children: [
                // Menyisakan ruang kosong di atas agar background asli terlihat sedikit
                const Spacer(flex: 1),

                Expanded(
                  flex:
                      14, // Membuat container cream memakan porsi besar ke bawah
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors
                          .orange100, // Warna cream/beige lembut sesuai desain kamu
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          32,
                        ), // Sudut melengkung di atas sheet
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

                        // Spacer fleksibel untuk mendorong tombol ke bawah
                        const Spacer(),

                        /// TOMBOL SAVE (Kondisional)
                        // Hanya muncul jika text field tidak kosong
                        /// TOMBOL SAVE (Kondisional)
                        // Hanya muncul jika text field tidak kosong
                        if (habitController.text.trim().isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CustomButton(
                              text: "Save",
                              onTap: () {
                                // 🔥 AMBIL TEKS NYA DAN KIRIM KE BLOC
                                final String uniqueName = habitController.text
                                    .trim();

                                context.read<DashboardBloc>().add(
                                  DashboardEvent.addHabit(uniqueName),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Custom habit berhasil dibuat!',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                // 3. LANGSUNG KEMBALI KE DASHBOARD UTAMA (Hapus semua tumpukan halaman PilihHabit)
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
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
    );
  }
}
