import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:mino/core/constants/app_colors.dart';

class MoodTile extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected; // Diperlukan untuk mendeteksi status klik
  final VoidCallback onTap;

  const MoodTile({
    super.key,
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── TARUH KODEMU DI SINI ───────────────────────────
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow:
                  isSelected // Menggunakan variabel properti di atas
                  ? [
                      BoxShadow(
                        color: AppColors.orange600.withValues(alpha: 0.4), // Warna shadow dengan alpha
                        blurRadius: 40,
                        spreadRadius: 3,
                      ),
                    ]
                  : [],
            ),
            child: Image.asset(
              imagePath, // Langsung panggil variabel karena ini StatelessWidget
              width: 44,
              height: 44,
            ),
          ),
          // ───────────────────────────────────────────────────
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.orange400 : Colors.white60, // Warna teks berubah saat dipilih
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
