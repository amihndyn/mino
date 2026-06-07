import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class ChallengeProgressCard extends StatefulWidget {
  final String title;
  final String? emoji; 
  final String? imageAsset; 
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
  State<ChallengeProgressCard> createState() => _ChallengeProgressCardState();
}

class _ChallengeProgressCardState extends State<ChallengeProgressCard> {
  // 🔥 State internal untuk menyimpan status dicentang atau tidak
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // Karena sekarang StatefulWidget, pemanggilan variabel menggunakan "widget.namaVariabel"
    final double progressValue = widget.totalProgress == 0 ? 0 : widget.currentProgress / widget.totalProgress;

    // Palet Warna disesuaikan dengan gambar
    const Color cardBgColor = Color.fromARGB(255, 95, 66, 41); 
    const Color textColor = AppColors.orange100; 
    const Color progressActiveColor = AppColors.orange500; 
    const Color progressBgColor = AppColors.orange100; 

    // Logika untuk menampilkan Gambar Asset atau Emoji
    Widget iconWidget;
    if (widget.imageAsset != null) {
      iconWidget = Image.asset(
        widget.imageAsset!,
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
    } else if (widget.emoji != null) {
      iconWidget = Text(
        widget.emoji!,
        style: const TextStyle(fontSize: 38),
      );
    } else {
      iconWidget = const SizedBox(width: 38, height: 38); 
    }

    // 🔥 GestureDetector untuk menangkap aksi klik pengguna
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked; // Membalikkan status saat diklik (true jadi false, dst)
        });
      },
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
                    widget.title,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
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
                        "${widget.currentProgress}/${widget.totalProgress}",
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

            // ── 3. Kanan (Lingkaran Checkbox Interaktif) ──
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // 🔥 Jika dicentang, warnanya jadi oranye. Jika tidak, transparan.
                color: _isChecked ? progressActiveColor : Colors.transparent,
                border: Border.all(
                  // 🔥 Border menyesuaikan status centang
                  color: _isChecked ? progressActiveColor : textColor,
                  width: 1.5, 
                ),
              ),
              child: _isChecked
                  ? const Icon(
                      Icons.check, // 🔥 Munculkan ikon centang
                      size: 18,
                      color: cardBgColor, // Warna centangnya (coklat mengikuti background)
                    )
                  : null, // Kosong jika tidak dicentang
            ),
          ],
        ),
      ),
    );
  }
}