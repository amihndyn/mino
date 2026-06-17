import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class NotifBerhasil extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onClose;

  const NotifBerhasil({
    super.key,
    this.message = "Jangan lupa isi refleksi hari ini ya!",
    this.icon = Icons.check_circle,
    this.iconColor = const Color(0xFF22C55E), // Default Hijau Berhasil
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = (MediaQuery.sizeOf(context).width / 375).clamp(0.8, 1.2);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16 * scale),
        image: const DecorationImage(
          image: AssetImage('assets/images/bg_journal.png'), // Menggunakan aset background kayu/tambang game Anda
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8 * scale,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 26 * scale),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.orange100,
                fontSize: 13 * scale,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(color: Colors.black),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose ?? () {},
            child: Container(
              padding: EdgeInsets.all(4 * scale),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.2),
              ),
              child: Icon(Icons.close_rounded, color: Colors.white, size: 18 * scale),
            ),
          ),
        ],
      ),
    );
  }
}