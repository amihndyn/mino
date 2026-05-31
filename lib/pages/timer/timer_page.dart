import 'package:flutter/material.dart';
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                // ── KUNCI PERUBAHAN: Menggunakan CustomAppBar milikmu ──
                const CustomAppBar(
                  title: 'Pomodoro', // Sesuaikan parameter ini jika CustomAppBar mu butuh properti lain
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
                    _timerValue = val;
                  },
                ),
                
                const SizedBox(height: 60),

                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4A3424), 
                      width: 4,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/crystal_cave.png'), 
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: 200, 
                    child: CustomButton(
                      text: 'Next',
                      onTap: () {
                        print('Mulai timer selama ${_timerValue.toInt()} menit');
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