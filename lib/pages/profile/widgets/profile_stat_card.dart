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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        // ✨ Background gelap elegan & efek bayangan (Ami)
        color: const Color(0xFF2B1D19).withOpacity(0.88),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 20,
          ),
        ],
        // ✨ Outline emas (Sausan)
        border: Border.all(
          color: AppColors.orange500, 
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ✨ Menggunakan custom image (Sausan)
          Image.asset(
            imagePath,
            height: 48,
            width: 48,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image_not_supported,
              color: Colors.white54,
              size: 40,
            ),
          ),
          const SizedBox(height: 12),
          
          // ✨ Teks Value (Angka/Statistik)
          Text(
            value,
            style: const TextStyle(
              color: AppColors.orange600, 
              fontSize: 28, // Ukuran disesuaikan agar tetap stand-out
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          
          // ✨ Teks Label
          Text(
            label,
            style: const TextStyle(
              color: AppColors.orange100, 
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}