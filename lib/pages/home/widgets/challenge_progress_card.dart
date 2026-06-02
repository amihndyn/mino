import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChallengeProgressCard extends StatelessWidget {
  final String title;
  final String? emoji; // Diubah menjadi opsional (bisa null)
  final String? imageAsset; // Ditambahkan untuk menampung gambar dari assets
  final int currentProgress;
  final int totalProgress;

  const ChallengeProgressCard({
    super.key,
    required this.title,
    this.emoji,
    this.imageAsset,
    required this.currentProgress,
    required this.totalProgress,
  });

  @override
  Widget build(BuildContext context) {
    // Menghitung value indikator dari 0.0 hingga 1.0
    final double progressValue = totalProgress == 0 ? 0 : currentProgress / totalProgress;

    // Palet Warna disesuaikan dengan gambar
    const Color cardBgColor = Color(0xff4A3320); // Cokelat gelap untuk latar belakang kartu
    const Color textColor = Color(0xffFBF1E3); // Krem terang untuk teks
    const Color progressActiveColor = Color(0xffFBA944); // Oranye cerah untuk progress
    const Color progressBgColor = Color(0xffF6E5CD); // Krem pucat untuk sisa bar

    // Logika untuk menampilkan Gambar Asset atau Emoji
    Widget iconWidget;
    if (imageAsset != null) {
      iconWidget = SvgPicture.asset(
        imageAsset!,
        width: 32,
        height: 32,
        fit: BoxFit.contain,
      );
    } else if (emoji != null) {
      iconWidget = Text(
        emoji!,
        style: const TextStyle(fontSize: 32),
      );
    } else {
      iconWidget = const SizedBox(width: 32, height: 32); // Fallback jika tidak ada dua-duanya
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20), // Sudut lebih melengkung
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Ikon / Gambar di Kiri (Memanggil widget yang sudah dicek di atas)
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
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
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
                    
                    // Teks Rasio Progress (cth: 12/30)
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

          // 3. Kanan (Lingkaran Checkbox)
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: textColor,
                width: 1.5, // Border putih tipis menyesuaikan gambar
              ),
            ),
          ),
        ],
      ),
    );
  }
}