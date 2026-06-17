import 'package:flutter/material.dart';

import 'greeting_section.dart';
import 'weekly_calendar.dart';

class HomeHeader extends StatelessWidget {
  // parameter variabel dari logika punyamu
  final String name;
  final int diamonds;

  // Constructor dinamis (tanpa const di depan class utama)
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
          // 1. Oper data name & diamonds ke GreetingSection (Logikamu)
          GreetingSection(
            name: name, 
            diamonds: diamonds,
          ),

        ],
      ),
    );
  }
}