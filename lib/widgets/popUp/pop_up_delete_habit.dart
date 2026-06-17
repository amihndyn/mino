import 'package:flutter/material.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

class PopUpDeleteHabit extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;
  
  final String title;
  final String description;
  final String leftButtonText;
  final String rightButtonText;

  const PopUpDeleteHabit({
    super.key, 
    this.onDelete, 
    this.onCancel,
    required this.title,           
    required this.description,     
    this.leftButtonText = "Log Out", 
    this.rightButtonText = "Cancel", 
  });

  @override
  Widget build(BuildContext context) {
    final double scale = (MediaQuery.sizeOf(context).width / 375).clamp(0.8, 1.2);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24 * scale),
      child: Container(
        padding: EdgeInsets.all(24 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFF261C14),
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(
            color: const Color(0xFFE6A84A).withOpacity(0.5),
            width: 1.5,
          ),
          // ── TAMBAHAN SHADOW DI SINI ──
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE6A84A).withOpacity(0.15), // Warna shadow gold transparan (efek glow)
              blurRadius: 20, // Seberapa blur shadow-nya
              spreadRadius: 2, // Seberapa jauh shadow menyebar
              offset: const Offset(0, 4), // Arah bayangan (x: 0, y: ke bawah 4)
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title, 
              style: TextStyle(
                color: AppColors.orange100,
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 12 * scale),
            
            Text(
              description, 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.orange100,
                fontSize: 13 * scale,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 24 * scale),
            Row(
              children: [
                // ── 1. TOMBOL KIRI (Tanpa Ikon Logout) ──
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDelete ?? () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE6A84A)),
                      padding: EdgeInsets.symmetric(vertical: 12 * scale),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20 * scale)),
                    ),
                    child: Text(
                      leftButtonText, 
                      style: TextStyle(color: const Color(0xFFE6A84A), fontSize: 13 * scale),
                    ),
                  ),
                ),
                
                SizedBox(width: 12 * scale),
                
                // ── 2. TOMBOL KANAN (Menggunakan CustomButton) ──
                Expanded(
                  child: CustomButton(
                    text: rightButtonText,
                    onTap: onCancel ?? () => Navigator.pop(context), 
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}