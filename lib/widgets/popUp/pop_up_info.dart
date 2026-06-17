import 'package:flutter/material.dart';
import 'package:mino/widgets/button/custom_button.dart';
import 'package:mino/core/constants/app_colors.dart';

class PopUpConfirmation extends StatelessWidget {
  final String title;
  final String description;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;
  final Widget? topIcon; 
  
  // ── 🛠️ FIX: Tambahkan parameter isSingleButton di sini agar tidak merah lagi ──
  final bool isSingleButton; 

  const PopUpConfirmation({
    super.key,
    required this.title,
    required this.description,
    this.leftButtonText = "Cancel", // Default diganti ke bahasa Inggris, required bool isSingleButton
    this.rightButtonText = "OK",
    this.onLeftTap,
    this.onRightTap,
    this.topIcon, 
    this.isSingleButton = false, // Default false (berarti muncul 2 tombol)
  });

  @override
  Widget build(BuildContext context) {
    final double scale = (MediaQuery.sizeOf(context).width / 375).clamp(0.8, 1.2);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24 * scale),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 32 * scale),
        decoration: BoxDecoration(
          // ── 🛠️ MODIFIKASI: Ditambahkan .withOpacity(0.85) agar background agak transparan ──
          color: const Color(0xFF261C14).withOpacity(0.85), 
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(
            color: const Color(0xFFE6A84A).withOpacity(0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE6A84A).withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── 1. TAMPILKAN ICON JIKA DISEDIAKAN ──
            if (topIcon != null) ...[
              topIcon!,
              SizedBox(height: 20 * scale),
            ],

            // ── 2. TITLE ──
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.orange100,
                fontSize: 20 * scale, // Sedikit disesuaikan ukurannya agar proporsional
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 12 * scale),

            // ── 3. DESCRIPTION ──
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.orange100.withOpacity(0.9),
                fontSize: 14 * scale,
                fontFamily: 'Poppins',
                height: 1.5,
              ),
            ),
            SizedBox(height: 32 * scale),

            // ── 4. LOGIKAL TOMBOL AKSI ──
            if (isSingleButton)
              // Jika true, tampilkan hanya 1 tombol OK di tengah (Lebar proporsional)
              SizedBox(
                width: 140 * scale,
                height: 44 * scale,
                child: CustomButton(
                  text: rightButtonText,
                  onTap: onRightTap ?? () => Navigator.pop(context),
                ),
              )
            else
              // Jika false, tampilkan 2 tombol sejajar (Row) seperti biasa
              Row(
                children: [
                  // Tombol Kiri (Outlined Style)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onLeftTap ?? () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE6A84A)),
                        padding: EdgeInsets.symmetric(vertical: 12 * scale),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20 * scale),
                        ),
                      ),
                      child: Text(
                        leftButtonText,
                        style: TextStyle(
                          color: const Color(0xFFE6A84A), 
                          fontSize: 13 * scale,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12 * scale),

                  // Tombol Kanan (CustomButton Filled Style)
                  Expanded(
                    child: SizedBox(
                      height: 44 * scale,
                      child: CustomButton(
                        text: rightButtonText,
                        onTap: onRightTap ?? () => Navigator.pop(context), 
                      ),
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