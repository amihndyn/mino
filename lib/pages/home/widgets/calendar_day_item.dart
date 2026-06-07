import 'package:flutter/material.dart';

class CalendarDayItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;

  const CalendarDayItem({
    super.key,
    required this.day,
    required this.date,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    // Palet warna disesuaikan dengan gambar referensi
    const Color goldBorderColor = Color(0xffD2A146);
    const Color creamColor = Color(0xffFBF1E3);
    const Color darkBrownColor = Color(0xff422E22);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Label Nama Hari (Sun, Mon, Tue, dst.)
        Text(
          day,
          style: const TextStyle(
            color: creamColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 16),

        // 2. Lingkaran Angka Tanggal
        Container(
          width: 40, // Menjaga dimensi tetap lingkaran sempurna
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? creamColor : Colors.transparent,
            border: isSelected
                ? null // Hilangkan border jika terpilih untuk efek solid penuh
                : Border.all(
                    color: goldBorderColor,
                    width: 1.5,
                  ),
          ),
          child: Text(
            date,
            style: TextStyle(
              color: isSelected ? darkBrownColor : creamColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}