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
        color: AppColors.orange200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        // Menyejajarkan gambar di kiri dan form di kanan dengan pas
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          // Kotak pembungkus gambar asset (Kotak Putih di sebelah kiri)
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.orange100,
              borderRadius: BorderRadius.circular(14),
            ),
            // DIUBAH KE PNG: Menggunakan Image.asset bawaan Flutter
            child: Image.asset(
              'assets/images/note.png',
              fit: BoxFit.contain,
              // Menggunakan errorBuilder sebagai fallback jika PNG gagal dimuat
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.edit_note_rounded, 
                size: 38, 
                color: AppColors.coklat600,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Area Teks Input di Sebelah Kanan Gambar
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null, // Agar text otomatis membungkus ke bawah jika panjang (multi-line fleksibel)
              decoration: const InputDecoration(
                // PERBAIKAN: Mengaktifkan garis bawah bawaan TextField (Underline)
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.coklat600, // Warna garis estetik di bawah teks sesuai desain
                    width: 1.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.coklat600, // Tetap gunakan warna coklat saat aktif mengetik
                    width: 1.5,
                  ),
                ),
                border: UnderlineInputBorder(),
                hintText: "Add your habit",
                // Mengatur padding dalam agar teks agak turun sedikit mendekati garis bawah
                contentPadding: EdgeInsets.only(bottom: 4, top: 8), 
              ),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.coklat800, // Warna teks inputan utama
              ),
            ),
          ),
        ],
      ),
    );
  }
}