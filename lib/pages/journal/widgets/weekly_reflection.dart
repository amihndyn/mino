import 'dart:ui';
import 'package:flutter/material.dart';

class WeeklyReflection extends StatelessWidget {
  const WeeklyReflection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0x14E6A84A),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0x33E6A84A), width: 1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Reflection',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFF5E6D3), fontFamily: 'Poppins'),
          ),
          SizedBox(height: 12),
          Text(
            'This week, you stayed consistent and made meaningful progress toward your goals.',
            style: TextStyle(fontSize: 14, color: Color(0xFFF5E6D3), fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}