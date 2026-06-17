import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/widgets/button/custom_button.dart'; // Sesuaikan path CustomButton milikmu

class FinishTimerPage extends StatelessWidget {
  final int completedMinutes; // Menerima durasi yang berhasil diselesaikan

  const FinishTimerPage({
    super.key,
    required this.completedMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900, // Warna dasar default
      body: Stack(
        children: [
          // ── Background Utama ───────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mendorong seluruh konten sedikit ke bawah dari status bar agar seimbang
                  const SizedBox(height: 40),

                  // ── 1. Teks Judul dan Subjudul ──
                  const Text(
                    'Focus Time Finish!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Small consistent steps today, bring you\ncloser to your goals!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  // Jarak dari teks menuju gambar karakter
                  const SizedBox(height: 30),

                  // ── 2. Gambar Karakter Selesai (Dioptimalkan ukurannya) ──
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/enam.svg', 
                      height: 280, // Diturunkan dari 550 agar ruang bernapas layar kembali normal
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Jarak dari gambar karakter ke kotak stat
                  const SizedBox(height: 30),

                  // ── 3. Barisan Kotak Statistik ──
                  Row(
                    children: [
                      // Kotak Kiri: Focus Duration
                      Expanded(
                        child: _buildStatCard(
                          iconPath: 'assets/images/watch.png',
                          defaultIcon: Icons.alarm,
                          title: 'Focus Duration',
                          value: '$completedMinutes minutes',
                        ),
                      ),
                      
                      const SizedBox(width: 16), // Jarak antar kotak

                      // Kotak Kanan: Diamond Obtained
                      Expanded(
                        child: _buildStatCard(
                          iconPath: 'assets/images/diamond.svg',
                          defaultIcon: Icons.diamond,
                          title: 'Diamond Obtained',
                          value: '$completedMinutes diamond',
                        ),
                      ),
                    ],
                  ),

                  // Jarak aman sebelum tombol di bagian paling bawah
                  const SizedBox(height: 40),

                  // ── 4. Tombol "I am great" ──
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48, // Sedikit ditebalkan agar tombol lebih click-friendly
                      child: CustomButton(
                        text: 'I am great',
                        onTap: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget bantuan untuk membuat kotak stat dengan pendukung ikon SVG
  Widget _buildStatCard({
    required String iconPath,
    required IconData defaultIcon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF261912).withOpacity(0.5), // Ditambahkan sedikit background gelap tipis agar kotak stat terbaca jelas
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8A838).withAlpha((0.3 * 255).toInt()),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pengecekan tipe berkas aset (jika PNG gunakan Image, jika SVG gunakan SvgPicture)
          iconPath.endsWith('.svg')
              ? SvgPicture.asset(
                  iconPath,
                  height: 32,
                  width: 32,
                  placeholderBuilder: (context) => Icon(
                    defaultIcon, 
                    color: const Color(0xFFE8A838), 
                    size: 32,
                  ),
                )
              : Image.asset(
                  iconPath,
                  height: 32,
                  width: 32,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    defaultIcon,
                    color: const Color(0xFFE8A838),
                    size: 32,
                  ),
                ),
          const SizedBox(height: 12),
          // Judul
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          // Nilai
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFE8A838),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}