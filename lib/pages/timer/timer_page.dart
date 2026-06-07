import 'package:flutter/material.dart';
// Pustaka flutter_svg telah dihapus
import 'package:mino/pages/timer/running_timer_page.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'widgets/balloon_slider.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  // Karena ini adalah TimerPage, default tab yang aktif adalah index 1 (Timer)
  int _activeTab = 1; 
  double _timerValue = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF140C08), 
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
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                const CustomAppBar(
                  title: 'Pomodoro', 
                ),
                
                const SizedBox(height: 20),

                // ── TAB MENU (Migrasi ke PNG) ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTopTab(index: 0, label: 'Challenge', imagePath: 'assets/images/tren.png'),
                        const SizedBox(width: 12),
                        _buildTopTab(index: 1, label: 'Timer', imagePath: 'assets/images/watch.png'),
                        const SizedBox(width: 12),
                        _buildTopTab(index: 2, label: 'Afirmation', imagePath: 'assets/images/plan.png'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // ── SLIDER ──
                BalloonSlider(
                  initialValue: _timerValue,
                  onChanged: (val) {
                    setState(() {
                      _timerValue = val;
                    });
                  },
                ),
                
                const SizedBox(height: 60),

                // ── GAMBAR LINGKARAN TENGAH ──
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4A3424), 
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/berlin.png', 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const Spacer(),

                // ── TOMBOL NAVIGASI NEXT ──
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: 212, 
                    child: CustomButton(
                      text: 'Next',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RunningTimerPage(
                              minutes: _timerValue.toInt(), 
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== WIDGET BUILDER UNTUK TAB DENGAN PNG ====================

  Widget _buildTopTab({required int index, required String label, required String imagePath}) {
    final bool isSelected = _activeTab == index;
    const Color themeGold = Color(0xffF2CD94);

    return GestureDetector(
      onTap: () {
        if (index == _activeTab) return; // Jika klik tab yang sama, biarkan saja

        if (index == 0) {
          // Jika klik tab Challenge (0), kembali ke FindPage (Karena FindPage ada di tumpukan bawah)
          Navigator.pop(context);
        } else {
          // Update status tab aktif (misal untuk Afirmation nanti)
          setState(() => _activeTab = index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? themeGold.withValues(alpha: 0.8) : Colors.white10,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Opacity(
              opacity: isSelected ? 1.0 : 0.4,
              child: Image.asset(
                imagePath, 
                width: 18, 
                height: 18,
                // Catatan: Jika ikon PNG Anda satu warna (monokrom) dan ingin diwarnai otomatis 
                // seperti fungsi colorFilter pada SVG sebelumnya, Anda bisa menggunakan properti color:
                // color: isSelected ? Colors.white : Colors.white70,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}