import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class JournalPaperStack extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  
  // ── 1. Update parameter dimensi menyesuaikan Figma ──
  final double paperWidth;
  final double paperHeight; 

  const JournalPaperStack({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.paperWidth = 327, // 🔥 Lebar diubah menjadi 327
    this.paperHeight = 468, // 🔥 Tinggi diubah menjadi 468
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: paperWidth,   // Mengunci lebar
      height: paperHeight, // Mengunci tinggi
      child: Stack(
        alignment: Alignment.center, 
        children: [
          // ── Kertas Paling Belakang (Miring ke Kiri) ─────────────
          Positioned.fill(
            child: Transform.rotate(
              angle: -8 * (math.pi / 180), 
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.orange100, // Ganti dengan kode warna cokelat muda Figma-mu jika ada
                  borderRadius: BorderRadius.circular(8), // ── 2. Radius diubah jadi 8
                  border: Border.all(color: AppColors.coklat900),
                ),
              ),
            ),
          ),
          
          // ── Kertas Utama Paling Atas (Tegak Lurus untuk Ngetik) ──
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.orange200,
                borderRadius: BorderRadius.circular(8), // ── 3. Radius diubah jadi 8
                border: Border.all(
                  color: AppColors.coklat900, // Ganti dengan kode warna stroke Figma-mu jika ada
                  width: 2, // ── 4. Ketebalan garis diubah jadi 2
                  strokeAlign: BorderSide.strokeAlignInside, // ── 5. Garis posisinya "Inside"
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 16,
                    spreadRadius: -2,
                    offset: const Offset(0, 8), 
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
          ),
        ],
      ),
    );
  }
}