import 'package:flutter/material.dart';

import 'greeting_section.dart';
import 'weekly_calendar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        18,
        20,
        18,
        28,
      ),

      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),

        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff3A2417),
            Color(0xff2B1B12),
          ],
        ),
      ),

      child: const Column(
        children: [
          GreetingSection(),

          SizedBox(height: 28),

          WeeklyCalendar(),
        ],
      ),
    );
  }
}