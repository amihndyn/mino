import 'package:flutter/material.dart';

class AddHabitHeader extends StatelessWidget {
  const AddHabitHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 60),

        const Text(
          "Add Habit",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),

        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}