import 'package:flutter/material.dart';

class MoodTile extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected; // Diperlukan untuk mendeteksi status klik
  final VoidCallback onTap;

  const MoodTile({
    super.key,
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── TARUH KODEMU DI SINI ───────────────────────────
          Container(
            padding: const EdgeInsets.all(8), 
            decoration: BoxDecoration(
              shape: BoxShape.circle, 
              boxShadow: isSelected // Menggunakan variabel properti di atas
                  ? [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.60), 
                        blurRadius: 45,       
                        spreadRadius: 5,      
                      ),
                    ]
                  : [], 
            ),
            child: Image.asset(
              imagePath, // Langsung panggil variabel karena ini StatelessWidget
              width: 64, 
              height: 64,
            ),
          ),
          // ───────────────────────────────────────────────────
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.white70,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}