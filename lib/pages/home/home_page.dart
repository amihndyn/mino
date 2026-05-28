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
      backgroundColor: const Color(0xff2B1B12),

      body: Column(
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

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar:
          const BottomNavbar(
        currentIndex: 0,
      ),
    );
  }
}