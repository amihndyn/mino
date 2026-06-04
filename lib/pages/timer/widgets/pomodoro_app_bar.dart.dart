import 'package:flutter/material.dart';
import 'package:mino/pages/timer/widgets/pomodoro_tab_menu.dart.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/pages/timer/widgets/timer_content.dart'; 
import 'package:mino/pages/timer/affirmation_page.dart';

class PomodoroMainPage extends StatefulWidget {
  const PomodoroMainPage({super.key});

  @override
  State<PomodoroMainPage> createState() => _PomodoroMainPageState();
}

class _PomodoroMainPageState extends State<PomodoroMainPage> {
  int _selectedIndex = 1; // Default ke tab 'Timer'

  @override
  Widget build(BuildContext context) {
    // 💡 Pindahkan list ke dalam build agar bisa menyisipkan fungsi setState untuk onBack
    final List<Widget> pages = [
      const Center(child: Text('Challenge Page', style: TextStyle(color: Colors.white))), 
      const TimerContent(), 
      AffirmationPage(
        onBack: () {
          setState(() {
            _selectedIndex = 1; // Paksa kembali ke halaman Timer (Index 1)
          });
        },
      ), 
    ];

    bool isAffirmation = _selectedIndex == 2;

    return Scaffold(
      body: Stack(
        children: [
          // ── SITUASI 1: JIKA USER MEMILIH TAB AFIRMASI (Index 2) ──
          if (isAffirmation)
            pages[2] // Render murni AffirmationPage tanpa embel-embel AppBar & Tab Menu

          // ── SITUASI 2: JIKA BUKAN TAB AFIRMASI (Index 0 atau 1) ──
          else ...[
            // Background Default aplikasimu
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Konten utama berupa AppBar, Tab Menu Oval, dan Isi Halaman Tengah
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const CustomAppBar(title: 'Pomodoro'),
                  const SizedBox(height: 10),
                  
                  PomodoroTabMenu(
                    selectedIndex: _selectedIndex,
                    onTabChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),

                  // Sisa ruang bawah diisi oleh Challenge Page atau Timer Content
                  Expanded(
                    child: pages[_selectedIndex],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}