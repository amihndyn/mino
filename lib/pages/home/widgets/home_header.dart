import 'package:flutter/material.dart';
import 'greeting_section.dart';
import 'weekly_calendar.dart';

class HomeHeader extends StatelessWidget {
  // 🔥 Logic Sausan: Menerima data name dan diamonds dari parent widget
  final String name;
  final int diamonds;

  const HomeHeader({
    super.key, 
    required this.name, 
    required this.diamonds,
  });

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 Gabungan UI + Logic Sausan: Mengoper data ke GreetingSection
          GreetingSection(
            name: name, 
            diamonds: diamonds,
          ),
        ],
      ),
    );
  }
}