import 'dart:math' as math; // Perlu import ini untuk nilai math.pi
import 'package:flutter/material.dart';

class JournalPaperStack extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;

  const JournalPaperStack({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Memastikan semua tumpukan mulai dari titik tengah
      children: [
        // ── 1. Kertas Paling Belakang (Miring ke Kiri) ─────────────────
        Transform.rotate(
          angle: -8 * (math.pi / 180), // Miring -3 derajat ke kiri
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0DFC0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12, width: 0.5),
            ),
          ),
        ),
        

        
        // ── 3. Kertas Utama Paling Atas (Tegak Lurus untuk Ngetik) ─────
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF0DC),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 16,
                spreadRadius: -2,
                offset: const Offset(0, 8), // Bayangan jatuh ke bawah
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(
              color: Color(0xFF3D2B1F),
              fontSize: 16,
              height: 1.6,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter topic',
              hintStyle: TextStyle(
                color: Color(0xFFB8956A),
                fontSize: 16,
              ),
              contentPadding: EdgeInsets.all(24),
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}