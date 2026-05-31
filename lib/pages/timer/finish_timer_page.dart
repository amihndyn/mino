import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: Stack(
        children: [
          // Background utama
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'), // Sesuaikan background-mu
                fit: BoxFit.cover,
              ),
              color: Color(0xFF140C08),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

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

                  const SizedBox(height: 40),

                  // ── 2. Gambar Karakter Selesai (enam.svg) ──
                  SvgPicture.asset(
                    'assets/images/enam.svg', // Pastikan path file ini benar
                    height: 250,
                  ),

                  const SizedBox(height: 40),

                  // ── 3. Barisan Kotak Statistik (Durasi & Berlian) ──
                  Row(
                    children: [
                      // Kotak Kiri: Focus Duration
                      Expanded(
                        child: _buildStatCard(
                          iconPath: 'assets/images/alarm.png', // Ganti dengan path icon jam/alarm kamu
                          defaultIcon: Icons.alarm,
                          title: 'Focus Duration',
                          value: '$completedMinutes minutes',
                        ),
                      ),
                      
                      const SizedBox(width: 16), // Jarak antar kotak

                      // Kotak Kanan: Diamond Obtained (1 Menit = 1 Berlian)
                      Expanded(
                        child: _buildStatCard(
                          iconPath: 'assets/images/diamond.png', // Ganti dengan path icon diamond kamu
                          defaultIcon: Icons.diamond,
                          title: 'diamond obtained',
                          value: '$completedMinutes diamond', // Nilainya sama dengan durasi menit
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // ── 4. Tombol "I am great" ──
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: CustomButton(
                        text: 'I am great',
                        onTap: () {
                          // Kembali ke halaman paling awal (Home)
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

  // Widget bantuan untuk membuat kotak stat dengan border glow
  Widget _buildStatCard({
    required String iconPath,
    required IconData defaultIcon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.transparent, // Background tembus pandang
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8A838).withValues(alpha: 0.3), // Garis emas transparan
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ikon
          Image.asset(
            iconPath,
            height: 32,
            errorBuilder: (context, error, stackTrace) => Icon(defaultIcon, color: const Color(0xFFE8A838), size: 32),
          ),
          const SizedBox(height: 12),
          // Judul
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          // Nilai
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFE8A838), // Warna emas/kuning
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}