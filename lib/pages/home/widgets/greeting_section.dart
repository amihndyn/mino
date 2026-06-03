import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/pages/journal/journal_parent_screen.dart'; // Import parent baru
import 'package:mino/pages/profile/profile_page.dart';

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
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Wednesday, April 22 2026",
              style: TextStyle(
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
                    builder: (context) => const JournalParentScreen(initialTabIndex: 1),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: goldBorderColor,
                    width: 2.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/diamond.svg',
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
            ),
            
            const SizedBox(width: 12),

            // 2. Tombol Avatar Profil
            GestureDetector(
              onTap: () {
                // Menghapus baris kode instansiasi ProfilePage() tunggal yang redundan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: Container(
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
                    color: const Color(0xffF6E5CD),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Color(0xffE5933A),
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}