import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HabitOptionCard extends StatelessWidget {
  final String title;
  final String imagePath; // Menggunakan String path gambar, bukan IconData
  final bool isSelected;
  final VoidCallback onTap;

  const HabitOptionCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8, // Ukuran vertical mengecil agar proporsional seperti kapsul
        ),
        decoration: BoxDecoration(
          // PERBAIKAN DI SINI: Menggunakan format 0xFF untuk warna hex
          color: isSelected ? AppColors.biru500 : const Color(0xFFFFF8EC), 
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Menampilkan gambar 3D dari asset
            Image.asset(
              imagePath,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                // Fallback jika file gambar belum ada di folder asset agar tidak crash
                return Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
            
            const SizedBox(width: 8),
            
            Flexible(
              child: Text(
                title,
                style: AppTextStyles.secondaryMedium.copyWith(
                  color: AppColors.coklat700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}