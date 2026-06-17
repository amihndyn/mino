import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class PopUpBerhasil extends StatelessWidget {
  final String message;
  final VoidCallback? onClose;

  const PopUpBerhasil({
    super.key, 
    this.message = "Habit berhasil diselesaikan!",
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = (MediaQuery.sizeOf(context).width / 375).clamp(0.8, 1.2);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      decoration: BoxDecoration(
        color: AppColors.orange100,
        borderRadius: BorderRadius.circular(40 * scale),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: const Color(0xFF22C55E), size: 24 * scale),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: const Color(0xFF261C14),
                fontSize: 13 * scale,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose ?? () {},
            child: Icon(Icons.close_rounded, color: const Color(0xFF261C14).withOpacity(0.6), size: 20 * scale),
          ),
        ],
      ),
    );
  }
}