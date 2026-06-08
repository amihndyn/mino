import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/pages/journal/journal_parent_screen.dart'; // Import parent baru
import 'package:intl/intl.dart';

class GreetingSection extends StatelessWidget {
  final String name;
  final int diamonds;

  const GreetingSection({
    super.key,
    required this.name,
    required this.diamonds,
  });

  @override
  Widget build(BuildContext context) {
    // Warna emas/oranye penghias sesuai gambar
    const Color goldBorderColor = Color(0xffD2A146);
    // Fungsi pembuat format tanggal otomatis real-time
    String formattedDate = DateFormat(
      "EEEE, MMMM dd yyyy",
    ).format(DateTime.now());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Kiri: Teks Sapaan dan Tanggal
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, $name", // Nama otomatis berubah sesuai user login dari Laravel
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formattedDate, // Tanggal otomatis mengikuti kalender HP
              style: const TextStyle(
                color: AppColors.orange300,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        // Kanan: Status Diamond dan Tombol Profil
        Row(
          children: [
            // 1. Capsul Counter Diamond (Membuka JournalParentScreen pada posisi Tab Progress)
            GestureDetector(
              onTap: () {
                // Diganti mengarah ke wadah induk (JournalParentScreen) dengan index 1 (Progress)
                // Ini menjamin state data di dalamnya tidak akan kosong atau ter-reset
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const JournalParentScreen(initialTabIndex: 1),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: goldBorderColor, width: 3.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/diamond.svg',
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$diamonds", // Jumlah diamond sinkron dengan database
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
