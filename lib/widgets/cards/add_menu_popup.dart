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
                // 1. Kartu Kiri (Add Routine) -> Pindah ke Pilih Habit
                Transform.rotate(
                  angle: -0.2,
                  child: MenuPopupCard(
                    title: "Add Routine",
                    subtitle: "Add a new routine to your life",
                    color: const Color(0xFFFF71AB),
                    imageAsset: 'assets/images/form.png', // Migrasi ke PNG
                    onTap: () {
                      // 1. Tutup dulu pop-up menunya
                      Navigator.pop(context);
                      
                      // 2. Navigasi ke halaman Pilih Habit
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PilihHabitPage()),
                      );
                    },
                  ),
                ),
                
                const SizedBox(width: 32),
                
                // 2. Kartu Kanan (Add Reflection) -> Pindah ke Mood Page
                Transform.rotate(
                  angle: 0.15,
                  child: MenuPopupCard(
                    title: "Add Reflection",
                    subtitle: "Reflect on your day, mood, and feelings",
                    color: const Color(0xFFA67CFF),
                    imageAsset: 'assets/images/cat.png', // Migrasi ke PNG
                    onTap: () {
                      // 1. Tutup dulu pop-up menunya
                      Navigator.pop(context);
                      
                      // 2. Navigasi ke halaman Mood
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

  const MenuPopupCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 145,
        height: 155,
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
            Expanded(
              // DIUBAH KE PNG: Menggunakan Image.asset bawaan Flutter
              child: Image.asset(
                imageAsset,
                fit: BoxFit.contain,
                // Menggunakan errorBuilder sebagai fallback jika PNG gagal dimuat
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
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