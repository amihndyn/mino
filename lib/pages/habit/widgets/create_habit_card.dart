import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class CreateHabitCard extends StatelessWidget {
  final TextEditingController controller;

  const CreateHabitCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.orange300,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          // Kotak pembungkus gambar asset
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(6), // Padding agar asset gambar terlihat rapi
            decoration: BoxDecoration(
              color: AppColors.orange100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(
              'assets/images/note.png', // PERBAIKAN: Menggunakan gambar asset sesuai request
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Cadangan jika file note.png belum di-register di pubspec.yaml
                return const Icon(Icons.edit_note_rounded, size: 38, color: AppColors.coklat600);
              },
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 2,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Release tension in your body",
              ),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.coklat800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}