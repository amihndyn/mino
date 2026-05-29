import 'package:flutter/material.dart';

class JournalBanner extends StatelessWidget {
  final String monthYear;

  const JournalBanner({
    super.key,
    required this.monthYear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.blueGrey,
      ),
      child: Text(
        monthYear,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}