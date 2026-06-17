import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:mino/core/constants/app_colors.dart'; 
import 'package:mino/core/constants/app_text_styles.dart';
import 'package:mino/pages/habit/widgets/create_habit_card.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/core/presentation/home/bloc/dashboard/dashboard_bloc.dart';

class EditHabitPage extends StatefulWidget {
  final int habitId;
  final String habitName;

  const EditHabitPage({
    super.key,
    required this.habitId,
    required this.habitName,
  });

  @override
  State<EditHabitPage> createState() => _EditHabitPageState();
}

class _EditHabitPageState extends State<EditHabitPage> {
  late final TextEditingController habitController;

  @override
  void initState() {
    super.initState();
    // Isi otomatis textfield dengan nama habit yang mau diedit
    habitController = TextEditingController(text: widget.habitName);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            bottom: false, 
            child: Column(
              children: [
                const Spacer(flex: 1), 
                Expanded(
                  flex: 14, 
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    decoration: const BoxDecoration(
                      color: AppColors.orange100, 
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32), 
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Judul halaman diubah
                            Text(
                              "Edit your habit",
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
                        CreateHabitCard(
                          controller: habitController,
                        ),
                        const Spacer(), 
                        if (habitController.text.trim().isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CustomButton(
                              text: "Save",
                              onTap: () {
                                final newName = habitController.text.trim();

                                if (newName.isEmpty) return;

                                context.read<DashboardBloc>().add(
                                  DashboardEvent.editHabit(
                                    widget.habitId,
                                    newName,
                                  ),
                                );

                                Navigator.pop(context, true);
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