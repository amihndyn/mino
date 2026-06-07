import 'package:flutter/material.dart';
import 'package:mino/pages/home/widgets/todays_progress_card.dart';

import '../../widgets/navbar/bottom_navbar.dart';
import 'widgets/home_header.dart';
import 'widgets/daily_activities_section.dart';
import 'widgets/challenge_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Inisialisasi variabel index untuk melacak halaman aktif di navbar
  int _navIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Wajib agar background tembus ke bawah navbar
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent, // Wajib agar scaffold transparan

      body: Stack(
        children: [
          /// 1. BACKGROUND UTAMA
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 2. KONTEN UTAMA
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const HomeHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        // Menggunakan const secara spesifik per widget yang konstan
                        const TodaysProgressCard(),
                        const SizedBox(height: 24),

                        const DailyActivitiesSection(),
                        const SizedBox(height: 24),

                        const ChallengeSection(),

                        // Ruang ekstra di bawah agar konten terakhir tidak tertutup navbar
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: _navIndex, // 2. Pasang variabel state di sini
        onTap: (i) {
          // 3. Sekarang setState bisa berjalan dengan normal untuk memperbarui UI
          setState(() {
            _navIndex = i;
          });
          
          // TODO: Tambahkan logika perpindahan antar halaman menggunakan PageController atau IndexedStack jika diperlukan
        },
      ),
    );
  }
}