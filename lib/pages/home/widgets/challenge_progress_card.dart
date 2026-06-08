import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class ChallengeProgressCard extends StatelessWidget { // 🔥 1. UBAH KE STATELESSWIDGET
  final String title;
  final String? emoji; 
  final String? imageAsset; 
  final int currentProgress;
  final int totalProgress;
  final bool isChecked; // 🔥 2. AMBIL STATUS LANGSUNG DARI MODEL BACKEND
  final VoidCallback? onToggle; // 🔥 3. TERIMA AKSI TAP DARI LUAR (UNTUK BLOC)

  const ChallengeProgressCard({
    super.key,
    required this.title,
    this.emoji,
    this.imageAsset,
    required this.currentProgress,
    required this.totalProgress,
    required this.isChecked, // Wajib diisi dari data state Bloc
    this.onToggle, // Aksi ketika card / checkbox ditekan
  });

  @override
  Widget build(BuildContext context) {
    // Perhitungan progress ratio
    final double progressValue = totalProgress == 0 ? 0 : currentProgress / totalProgress;

    // Palet Warna
    const Color cardBgColor = Color.fromARGB(255, 95, 66, 41); 
    const Color textColor = AppColors.orange100; 
    const Color progressActiveColor = AppColors.orange500; 
    const Color progressBgColor = AppColors.orange100; 

    // Logika menampilkan Gambar Asset atau Emoji
    Widget iconWidget;
    if (imageAsset != null && imageAsset!.isNotEmpty) {
      iconWidget = Image.asset(
        imageAsset!,
        width: 32,
        height: 32,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            Icons.broken_image,
            size: 24,
            color: textColor,
          ),
        ),
      );
    } else if (emoji != null && emoji!.isNotEmpty) {
      iconWidget = Text(
        emoji!,
        style: const TextStyle(fontSize: 38),
      );
    } else {
      iconWidget = const SizedBox(width: 38, height: 38); 
    }

    return GestureDetector(
      onTap: onToggle, // 🔥 4. UTUS AKSI KETIKA CARD DI-TAP LANGSUNG KE BLOC
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(20), 
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Ikon / Gambar di Kiri 
            iconWidget,
            
            const SizedBox(width: 16),

            // 2. Tengah (Judul & Progress Bar)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      // 🔥 5. OPSIONAL: Beri efek coret tipis jika challenge sudah sukses/checked
                      decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  Row(
                    children: [
                      // Linear Progress Bar
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: progressValue,
                            minHeight: 8,
                            backgroundColor: progressBgColor,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              progressActiveColor,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 10),
                      
                      // Teks Rasio Progress 
                      Text(
                        "$currentProgress/$totalProgress",
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            
            const SizedBox(width: 16),

            // 3. Kanan (Lingkaran Checkbox Sinkron dengan Data Laravel)
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isChecked ? progressActiveColor : Colors.transparent,
                border: Border.all(
                  color: isChecked ? progressActiveColor : textColor,
                  width: 1.5, 
                ),
              ),
              child: isChecked
                  ? const Icon(
                      Icons.check,
                      size: 18,
                      color: cardBgColor,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}