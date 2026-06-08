import 'package:flutter/material.dart';

import 'greeting_section.dart';
import 'weekly_calendar.dart';

class HomeHeader extends StatelessWidget {
  // 🔥 1. TAMBAHKAN PARAMETER VARIABEL DI SINI
  final String name;
  final int diamonds;

  // 🔥 2. MASUKKAN KE CONSTRUCTOR (Hapus kata 'const' di depan HomeHeader)
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

      child: Column( // 🔥 3. HAPUS KATA 'const' di depan Column karena anaknya sekarang dinamis
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // 🔥 4. OPER DATA NAME DAN DIAMONDS KE GREETING SECTION
          GreetingSection(
            name: name, 
            diamonds: diamonds,
          ),

          const SizedBox(height: 28),

          const WeeklyCalendar(), // Berikan const di widget yang statis saja
        ],
      ),
    );
  }
}