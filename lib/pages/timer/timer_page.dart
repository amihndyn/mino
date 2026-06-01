import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:mino/pages/timer/running_timer_page.dart';
import 'package:mino/pages/timer/widgets/pomodoro_tab_menu.dart.dart'; 
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'widgets/balloon_slider.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _selectedTabIndex = 1; 
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
                
                // ── Menggunakan CustomAppBar milikmu ──
                const CustomAppBar(
                  title: 'Pomodoro', 
                ),
                
                const SizedBox(height: 20),

                PomodoroTabMenu(
                  selectedIndex: _selectedTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 40),

                BalloonSlider(
                  initialValue: _timerValue,
                  onChanged: (val) {
                    setState(() {
                      _timerValue = val;
                    });
                  },
                ),
                
                const SizedBox(height: 60),

                // ── MODIFIKASI: Menggunakan ClipOval agar kompatibel dengan SVG di masa depan ──
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
                      'assets/images/crystal_cave.png', 
                      fit: BoxFit.cover,
                      // Jika nanti aset berubah menjadi SVG, Anda tinggal menggantinya menjadi:
                      // child: SvgPicture.asset('assets/images/crystal_cave.svg', fit: BoxFit.cover),
                    ),
                  ),
                ),

                const Spacer(),

                // Tombol Navigasi Menuju Running Timer
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: 200, 
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
}