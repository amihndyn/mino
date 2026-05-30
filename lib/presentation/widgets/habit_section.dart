import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'habit_option_card.dart';

class HabitSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> habits;
  final String? selectedHabit;
  final Function(String) onSelect;

  const HabitSection({
    super.key,
    required this.title,
    required this.habits,
    required this.selectedHabit,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.sectionTitleBold.copyWith(
            color: AppColors.coklat700,
          ),
        ),
        
        const SizedBox(height: 12),
        
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: habits.map((habit) {
            final habitName = habit['title'] as String;
            final imagePath = habit['icon'] as String; // Dipastikan membaca String dari data list

            return HabitOptionCard(
              title: habitName,
              imagePath: imagePath,
              isSelected: selectedHabit == habitName,
              onTap: () => onSelect(habitName),
            );
          }).toList(),
        ),
      ],
    );
  }
}