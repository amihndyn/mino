import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class ProfileStatCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final String value;

  const ProfileStatCard({
    super.key,
    required this.imagePath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10), // Padding dikecilkan sedikit agar longgar
      decoration: BoxDecoration(
        color: const Color(0xFF2B1D19).withOpacity(0.88),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 20,
          ),
        ],
        border: Border.all(
          color: AppColors.orange500, 
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. 🔝 PALING ATAS: Gambar dikunci ukurannya (Fix Gambar Ga Keluar)
          SizedBox(
            height: 52,
            width: 52,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  color: Colors.white24,
                  size: 32,
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // 2. 🏷️ DI TENGAH: Teks Label (Nama Statistik)
          Text(
            label,
            style: const TextStyle(
              color: AppColors.orange200, 
              fontSize: 14, // Ukuran font disesuaikan dengan box GridView
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          
          // 3. 🔢 PALING BAWAH: Teks Value (Angka/Jumlah)
          Text(
            value,
            style: const TextStyle(
              color: AppColors.orange600, 
              fontSize: 22, 
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}