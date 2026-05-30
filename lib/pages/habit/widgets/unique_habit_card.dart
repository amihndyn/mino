import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

import '../create_unique_habit_page.dart';

class UniqueHabitCard extends StatelessWidget {
  const UniqueHabitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CreateUniqueHabitPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.orange200,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/stars.png',
              width: 26,
              height: 26,
            ),
            
            Expanded(
              child: Text(
                "Create a unique habit",
                textAlign: TextAlign.center, // Memastikan teks rata tengah
                style: AppTextStyles.bodyMedium.copyWith(
                  color: const Color(0xFF707070), // Format penulisan warna diperbaiki
                ),
              ),
            ),
            
            // Penyeimbang ukuran gambar bintang agar teks persis di tengah Container
            const SizedBox(width: 26), 
          ],
        ),
      ),
    );
  }
}