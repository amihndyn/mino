import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:provider/provider.dart';

import '../../providers/habit_provider.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/cards/habit_card.dart';

class PilihHabitPage extends StatelessWidget {
  const PilihHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    final habits = habitProvider.habits;

    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: AppBar(
        backgroundColor: AppColors.coklat900,
        title: const Text(
          'Your Habits',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

      body: habits.isEmpty
          ? const Center(
              child: Text(
                'Belum ada habit.\nTambah habit baru!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: 'Daily Habits'),
                  const SizedBox(height: AppSizes.lg),
                  ...habits.map(
                    (habit) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.md),
                      child: HabitCard(
                        title: habit.title,
                        subtitle: habit.subtitle,
                        image: habit.image,
                      ),
                    ),
                  ),
                ],
              ),
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange500,
        onPressed: () {},
        child: const Icon(Icons.add_rounded, color: AppColors.coklat900),
      ),
    );
  }
}
