import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna emas/oranye penghias sesuai gambar
    const Color goldBorderColor = Color(0xffD2A146);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Kiri: Teks Sapaan dan Tanggal
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Hi, Keysha",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32, // Ukuran sedikit diperbesar agar lebih tegas
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Wednesday, April 22 2026",
              style: TextStyle(
                color: AppColors.orange300, // Pastikan warna ini bernuansa emas/oranye redup
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        // Kanan: Status Diamond dan Tombol Profil
        Row(
          children: [
            // 1. Capsul Counter Diamond
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25), // Background gelap transparan
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: goldBorderColor,
                  width: 2.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/diamond.png',
                    width: 26,
                    height: 26,
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "80",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),

            // 2. Tombol Avatar Profil Kustom (Aksen Lingkaran Emas + Kotak 3D)
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: goldBorderColor,
                  width: 2.5,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xffF6E5CD), // Warna krem latar avatar
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 1,
                      offset: const Offset(0, 2), // Efek bayangan tebal di bawah (3D)
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Color(0xffE5933A), // Warna figur orang oranye tua
                  size: 28,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}