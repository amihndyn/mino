import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class ProfileStatCard extends StatelessWidget {
  final String imagePath;
  final String value;
  final String label;

  const ProfileStatCard({
    super.key,
    required this.imagePath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // 🛠️ Warna background gelap sesuai screenshot
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.orange500, // 🛠️ Outline emas
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🛠️ Widget gambar pengganti Icon
          Image.asset(
            imagePath,
            height: 48, // Sesuaikan ukurannya jika kalender.png terlalu besar/kecil
            width: 48,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image_not_supported,
              color: Colors.transparent,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.orange100, // Teks label warna terang
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.orange600, // Teks value warna emas
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}