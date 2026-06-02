import 'package:flutter/material.dart';
import 'mood_tile.dart';

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

  // ── Fungsi bantuan untuk membuat item agar kode lebih bersih ──
  Widget _buildMoodItem(MoodItem mood) {
    final isSelected = selectedMood == mood.label;
    return MoodTile(
      imagePath: mood.imagePath,
      label: mood.label,
      isSelected: isSelected,
      onTap: () => onMoodSelected(mood.label),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pastikan list moods ada 5 (sesuai data kamu) agar tidak error out of range
    if (moods.length < 5) return const SizedBox.shrink();

    // Nilai jarak yang bisa kamu atur
    const double spacingHorizontal = 12.0; // Jarak kanan-kiri antar emoji
    const double spacingVertical = 16.0;   // Jarak atas-bawah antar baris

    return Column(
      mainAxisSize: MainAxisSize.min, // Sesuaikan tinggi column dengan isinya
      children: [
        // ── BARIS PERTAMA: 3 Emoji (Index 0, 1, 2) ──
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMoodItem(moods[0]),
            const SizedBox(width: spacingHorizontal),
            _buildMoodItem(moods[1]),
            const SizedBox(width: spacingHorizontal),
            _buildMoodItem(moods[2]),
          ],
        ),
        
        const SizedBox(height: spacingVertical),
        
        // ── BARIS KEDUA: 2 Emoji (Index 3, 4) ──
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMoodItem(moods[3]),
            const SizedBox(width: spacingHorizontal),
            _buildMoodItem(moods[4]),
          ],
        ),
      ],
    );
  }
}