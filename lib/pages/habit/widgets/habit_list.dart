import 'package:flutter/material.dart';

import 'package:mino/core/constants/app_sizes.dart';

import '../../../widgets/cards/habit_card.dart';

class HabitList extends StatelessWidget {
  final List<Map<String, String>> habits;

  const HabitList({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      itemCount: habits.length,

      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSizes.md),

      itemBuilder: (context, index) {
        final habit = habits[index];

        return HabitCard(
          title: habit['title'] ?? '',
          subtitle: habit['subtitle'] ?? '',
          image: habit['image'] ?? '',
        );
      },
    );
  }
}