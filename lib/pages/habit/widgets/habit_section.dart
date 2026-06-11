import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'habit_option_card.dart';

class HabitSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> habits;
  final List<String> selectedHabits; 
  final Function(String) onSelect;

  const HabitSection({
    super.key,
    required this.title,
    required this.habits,
    required this.selectedHabits,
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
            
            // 🔥 PERBAIKAN DI SINI: Berikan tanda tanya (?) agar menjadi String nullable
            final imagePath = habit['icon'] as String?;

            return HabitOptionCard(
              title: habitName,
              imagePath: imagePath, // Mengirim path yang bisa bernilai null ke Card
              isSelected: selectedHabits.contains(habitName), 
              onTap: () => onSelect(habitName),
            );
          }).toList(),
        ),
      ],
    );
  }
}