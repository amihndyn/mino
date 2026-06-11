import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HabitOptionCard extends StatelessWidget {
  final String title;
  final String? imagePath; // Di sini sudah benar String? (nullable)
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
          vertical: 8, 
        ),
        decoration: BoxDecoration(
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
            // 🔥 PERBAIKAN DI SINI: Cek apakah imagePath ada atau null
            imagePath != null
                ? Image.asset(
                    imagePath!, // Pakai tanda seru (!) karena kita sudah yakin tidak null
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback jika path ada di database tapi file PNG-nya belum ditaruh di folder asset
                      return const Icon(
                        Icons.star_rounded,
                        color: Colors.orange,
                        size: 24,
                      );
                    },
                  )
                : const Icon(
                    // 🔥 Fallback jika memang dari awal imagePath-nya null (Habit Custom/Baru)
                    Icons.star_rounded,
                    color: Colors.orange,
                    size: 24,
                  ),
            
            const SizedBox(width: 8),
            
            Flexible(
              child: Text(
                title,
                style: AppTextStyles.secondaryMedium.copyWith(
                  // Sedikit tips: jika card sedang di-select, teksnya bisa diubah putih agar kontras dengan warna biru500
                  color: isSelected ? Colors.white : AppColors.coklat700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}