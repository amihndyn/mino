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
        20,
        35,
        18,
        28,
      ),

      child: const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          GreetingSection(),
        ],
      ),
    );
  }
}