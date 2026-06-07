import 'package:flutter/material.dart';
import 'package:mino/pages/habit/pilih_habit_page.dart';
import 'package:mino/pages/mood/mood_page.dart';

class AddMenuPopup extends StatelessWidget {
  const AddMenuPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Area klik untuk menutup pop-up jika user klik area kosong
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
          ),
          
          // Posisi kedua kartu
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 1. Kartu Kiri (Add Routine)
                Transform.rotate(
                  angle: -0.5,
                  child: MenuPopupCard(
                    title: "Add Routine",
                    subtitle: "Add a new routine to your life",
                    color: const Color(0xFFFF8BD4),
                    imageAsset: 'assets/images/form.png',
                    imageHeight: 65, // Ubah angka ini untuk mengatur besar gambar form.png
                    imageAngle: 0.2,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1
                    ),
                    subtitleStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                      letterSpacing: 1
                    ),
                    // ----------------------------------
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PilihHabitPage()),
                      );
                    },
                  ),
                ),
                
                const SizedBox(width: 55),
                
                // 2. Kartu Kanan (Add Reflection)
                Transform.rotate(
                  angle: 0.5,
                  child: MenuPopupCard(
                    title: "Add Reflection",
                    subtitle: "Reflect on your day, mood, and feelings",
                    color: const Color(0xFFAC87E4),
                    imageAsset: 'assets/images/cat.png',
                    imageHeight: 65, // Misalnya cat.png ingin dibuat lebih besar
                    imageAngle: -0.5, // Atur kemiringan khusus untuk gambar cat.png
                    // --- TAMBAHAN STYLE KARTU KANAN ---
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1
                    ),
                    subtitleStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                      letterSpacing: 1
                    ),
                    // ----------------------------------
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MoodPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuPopupCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String imageAsset;
  final VoidCallback onTap;
  
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? imageHeight;
  // --- TAMBAH PARAMETER ROTASI GAMBAR ---
  final double imageAngle; 

  const MenuPopupCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imageAsset,
    required this.onTap,
    this.titleStyle,
    this.subtitleStyle,
    this.imageHeight = 50, // Nilai default jika tidak diisi
    this.imageAngle = 0.0, // Nilai default (0 = tidak miring)
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 141,
        height: 148,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- HAPUS EXPANDED, GUNAKAN TRANSFORM UNTUK ROTASI ---
            Transform.rotate(
              angle: imageAngle,
              child: Image.asset(
                imageAsset,
                height: imageHeight, // Sekarang tinggi gambar akan patuh pada nilai ini
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image, 
                  size: 40, 
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: titleStyle ?? const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: subtitleStyle ?? const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}