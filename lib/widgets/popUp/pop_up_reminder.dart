import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class PopUpReminder extends StatelessWidget {
  final String message;
  final VoidCallback? onClose;

  const PopUpReminder({
    super.key, 
    this.message = "Jangan lupa kerjakan challenge hari ini ya!",
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = (MediaQuery.sizeOf(context).width / 375).clamp(0.8, 1.2);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFFBEFDD), // Sedikit disesuaikan agar warna cream-nya hangat seperti gambar
        borderRadius: BorderRadius.circular(20 * scale), // Diubah dari 40 ke 20 agar lekukan pas
      ),
      child: Row(
        children: [
          // 🔥 MODIFIKASI ICON JAM: Lingkaran biru solid dengan jarum putih
          Container(
            padding: EdgeInsets.all(6 * scale),
            decoration: const BoxDecoration(
              color: Color(0xFF3652F9), // Biru cerah sesuai gambar
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.access_time_filled_rounded, 
              color: Colors.white, 
              size: 20 * scale,
            ),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.orange100,
                fontSize: 14 * scale,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // 🔥 MODIFIKASI TOMBOL CLOSE: Lebih tipis dan tegas
          GestureDetector(
            onTap: onClose ?? () {},
            child: Padding(
              padding: EdgeInsets.all(4 * scale),
              child: Icon(
                Icons.close, // Menggunakan close standar agar garisnya tipis pas
                color: const Color(0xFF261C14), 
                size: 22 * scale,
              ),
            ),
          ),
        ],
      ),
    );
  }
}