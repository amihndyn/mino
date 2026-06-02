import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ActivityItemCard extends StatelessWidget {
  final String title;
  final String? emoji; // Buat jadi opsional
  final String? imageAsset; // Untuk menampung gambar dari assets
  final bool isCompleted; // Menambahkan variabel state untuk checklist

  const ActivityItemCard({
    super.key,
    required this.title,
    this.emoji,
    this.imageAsset,
    this.isCompleted = false, // Default false agar tidak error jika tidak diisi
  });

  @override
  Widget build(BuildContext context) {
    // Definisi palet warna berdasarkan gambar referensi
    const Color cardBgColor = Color(0xffF6E5CD); // Latar belakang krem lembut
    const Color darkBrownColor = Color(0xff422E22); // Warna teks dan border lingkaran

    // Logika untuk menampilkan Gambar Asset atau Emoji
    Widget iconWidget;
    if (imageAsset != null) {
      iconWidget = SvgPicture.asset(
        imageAsset!,
        width: 30, // Sesuaikan dengan ukuran emoji
        height: 30,
        fit: BoxFit.contain,
      );
    } else if (emoji != null) {
      iconWidget = Text(
        emoji!,
        style: const TextStyle(fontSize: 30),
      );
    } else {
      iconWidget = const SizedBox(width: 30, height: 30); // Fallback
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20), // Sudut melengkung tebal
      ),
      child: Row(
        children: [
          // 1. Emoji / Ikon Gambar di Sisi Kiri
          iconWidget,
          
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
                    color: cardBgColor, // Warna centang (mengikuti warna krem)
                    size: 18,
                  )
                : null, // Kosong jika belum complete
          ),
        ],
      ),
    );
  }
}