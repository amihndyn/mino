import 'dart:ui';
import 'package:flutter/material.dart';

class MonthlyReflection extends StatelessWidget {
  final String? selectedMonth;

  const MonthlyReflection({
    super.key,
    this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0x14E6A84A), // Warna gradasi agak kebiruan untuk membedakan dengan weekly
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0x33E6A84A), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly Reflection ~${selectedMonth ?? "This Month"} ',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFF5E6D3), fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 12),
          const Text(
            'Looking back at this month, you have shown incredible emotional growth and resilience.',
            style: TextStyle(fontSize: 14, color: Color(0xFFF5E6D3),  fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}