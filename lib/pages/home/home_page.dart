import 'package:flutter/material.dart';

import '../../widgets/navbar/bottom_navbar.dart';
import 'widgets/home_header.dart';
import 'widgets/reflection_card.dart';
import 'widgets/daily_activities_section.dart';
import 'widgets/challenge_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Wajib agar background tembus ke bawah navbar
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent, // Wajib agar scaffold transparan

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const HomeHeader(),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: const [
                      ReflectionCard(),
                      SizedBox(height: 24),

                      DailyActivitiesSection(),
                      SizedBox(height: 24),

                      ChallengeSection(),

                      // Ruang ekstra di bawah agar konten terakhir tidak tertutup navbar
                      SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavbar(
        currentIndex: 0,
        onTap: (index) {
          // Tambahkan logika perpindahan tab di sini
        },
      ),
    );
  }
}