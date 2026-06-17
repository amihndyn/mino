import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class PopUpLeave extends StatelessWidget {
  final VoidCallback? onLeave;
  final VoidCallback? onCancel;

  const PopUpLeave({super.key, this.onLeave, this.onCancel});

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
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Leave the Mine?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 12 * scale),
            Text(
              "Your diamonds and progress are safe. Come back anytime to continue your journey. 💎",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFF5E6D3).withOpacity(0.8),
                fontSize: 13 * scale,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 24 * scale),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onLeave ?? () => Navigator.pop(context),
                    icon: Icon(Icons.logout_rounded, size: 16 * scale, color: const Color(0xFFE6A84A)),
                    label: Text(
                      "Log Out",
                      style: TextStyle(color: const Color(0xFFE6A84A), fontSize: 13 * scale),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE6A84A)),
                      padding: EdgeInsets.symmetric(vertical: 12 * scale),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20 * scale)),
                    ),
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8C6439), Color(0xFF593E22)],
                      ),
                      borderRadius: BorderRadius.circular(20 * scale),
                    ),
                    child: ElevatedButton(
                      onPressed: onCancel ?? () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 12 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20 * scale)),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: const Color(0xFFF5E6D3), fontSize: 13 * scale, fontWeight: FontWeight.bold),
                      ),
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