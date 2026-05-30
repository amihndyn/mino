import 'package:flutter/material.dart';
import 'mood_tile.dart'; // Pastikan path import MoodTile sudah benar

class MoodItem {
  final String imagePath;
  final String label;
  const MoodItem({required this.imagePath, required this.label});
}

class MoodGrid extends StatelessWidget {
  final List<MoodItem> moods;
  final String? selectedMood;
  final ValueChanged<String> onMoodSelected;

  const MoodGrid({
    super.key,
    required this.moods,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Kita gunakan LayoutBuilder untuk menghitung lebar layar secara dinamis
    return LayoutBuilder(
      builder: (context, constraints) {
        // Menghitung lebar per item agar pas dibagi 3 kolom (dikurangi sedikit untuk jarak/spacing)
        final double itemWidth = (constraints.maxWidth - 32) / 3;

        return Wrap(
          alignment: WrapAlignment.center,      // ── MEMBUAT BARIS KEDUA DI TENGAH ──
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,                          // Jarak antar emoji secara horizontal
          runSpacing: 20,                       // Jarak antar baris secara vertikal
          children: moods.map((mood) {
            final isSelected = selectedMood == mood.label;

            return SizedBox(
              width: itemWidth, // Memaksa ukuran tiap item agar konsisten seperti grid
              child: MoodTile(
                imagePath: mood.imagePath,
                label: mood.label,
                isSelected: isSelected,
                onTap: () => onMoodSelected(mood.label),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}