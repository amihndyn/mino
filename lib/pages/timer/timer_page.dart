import 'package:flutter/material.dart';
import 'package:mino/core/presentation/home/bloc/focus_timer/focus_timer_bloc.dart';
import 'package:mino/pages/timer/running_timer_page.dart';
import 'package:mino/pages/timer/widgets/pomodoro_tab_menu.dart';
// 💡 .dart.dart diubah menjadi .dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'widgets/balloon_slider.dart';
import 'package:mino/pages/timer/affirmation_page.dart'; 

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
    bool isAffirmation = _selectedTabIndex == 2;

    // 🔥 1. BUNGKUS MULAI DARI SINI
    return BlocListener<FocusTimerBloc, FocusTimerState>(
      listener: (context, state) {
        state.maybeWhen(
          started: (timerId) {
            // Jika sukses dapat ID dari Laravel, langsung pindah halaman!
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RunningTimerPage(
                  minutes: _timerValue.toInt(),
                  timerId: timerId, // 🔥 Kirim ID ini ke halaman berikutnya
                ),
              ),
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold( // <-- Scaffold milikmu sekarang menjadi child di sini
        backgroundColor: const Color(0xFF140C08), 
        body: Stack(
          children: [
            // ── SITUASI 1: JIKA USER MEMILIH TAB AFIRMASI (Index 2) ──
            if (isAffirmation)
              AffirmationPage(
                // Callback untuk kembali ke halaman Timer (Index 1)
                onBack: () {
                  setState(() {
                    _selectedTabIndex = 1; 
                  });
                },
              )

            // ── SITUASI 2: JIKA BUKAN TAB AFIRMASI (Index 0 atau 1) ──
            else ...[
              // Background Default Utama
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg_login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Konten Foreground (AppBar, Menu Tab Oval, & Konten Tengah)
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    
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
                    
                    // Isi Konten Tengah (Challenge / Timer Content)
                    Expanded(
                      child: _buildBodyContent(),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    ); // <-- Tutup BlocListener
  }

  // ... (lanjut ke fungsi _buildBodyContent di bawahnya)

  // Fungsi pembantu untuk menukar konten tengah berdasarkan tab
  Widget _buildBodyContent() {
    switch (_selectedTabIndex) {
      case 0:
        return const Center(
          child: Text('Challenge Page', style: TextStyle(color: Colors.white)),
        );
      case 1:
        return Column(
          children: [
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
                border: Border.all(color: const Color(0xFF4A3424), width: 4),
                image: const DecorationImage(
                  image: AssetImage('assets/images/berlin.png'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
// ... potongan kode di dalam _buildBodyContent() -> case 1:
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: 200, 
                  child: CustomButton(
                    text: 'Next',
                    onTap: () {
                      // 🔥 2. PANGGIL EVENT START KE BLOC SAAT TOMBOL NEXT DITEKAN
                      context.read<FocusTimerBloc>().add(const FocusTimerEvent.startFocus());
                    },
                  ),
                ),
              ),
              // ...
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}