import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0x33E6A84A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Icon(
            Icons.local_fire_department,
            color: Color(0xffE6A84A),
          ),
          SizedBox(width: 6),
          Text(
            "80",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}