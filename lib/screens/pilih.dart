import 'dart:math';
import 'package:flutter/material.dart';

class Pilih extends StatelessWidget {
  const Pilih({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // LEFT CARD
          Positioned(
            left: 25,
            top: 20,child: _customCard(
                color: const Color(0xFFEF7DCA),
                imagePath: "assets/images/form.png",
                title: "Add Routine",
                subtitle: "Add a new routine to\nyour life",
              ),
            ),

          // RIGHT CARD
          Positioned(
            right: 25,
            top: 20,
            child: _customCard(
                color: const Color(0xFFB08AEF),
                imagePath: "assets/images/cat.png",
                title: "Add Reflection",
                subtitle: "Reflect on your day,\nmood and feelings",
              ),
            ),
        ],
      ),
    );
  }

  static Widget _customCard({
    required Color color,
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 170,
      height: 210,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(34),
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 75,
            height: 75,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 18),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.none,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              height: 1.4,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}