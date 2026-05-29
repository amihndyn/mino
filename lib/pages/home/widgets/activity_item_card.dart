import 'package:flutter/material.dart';

class ActivityItemCard extends StatelessWidget {
  final String title;
  final String emoji;
  final bool isCompleted; // Menyiapkan state jika nanti ingin diubah menjadi tercentang

  const ActivityItemCard({
    super.key,
    required this.title,
    required this.emoji,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    // Definisi palet warna berdasarkan gambar referensi
    const Color cardBgColor = Color(0xffF6E5CD); // Latar belakang krem lembut
    const Color darkBrownColor = Color(0xff422E22); // Warna teks dan border lingkaran

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20), // Sudut melengkung tebal
      ),
      child: Row(
        children: [
          // 1. Emoji / Ikon di Sisi Kiri
          Text(
            emoji,
            style: const TextStyle(
              fontSize: 30, // Mengatur ukuran emoji agar proporsional
            ),
          ),
          const SizedBox(width: 16),

          // 2. Judul Aktivitas di Tengah
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: darkBrownColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),

          // 3. Lingkaran Indikator (Ceklis/Radio) di Sisi Kanan
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: darkBrownColor,
                width: 2.2, // Ketebalan garis lingkaran luar
              ),
              color: isCompleted ? darkBrownColor : Colors.transparent,
            ),
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    color: cardBgColor,
                    size: 18,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}