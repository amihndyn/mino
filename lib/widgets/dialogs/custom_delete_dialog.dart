import 'package:flutter/material.dart';
import 'package:mino/widgets/button/custom_button.dart'; // Sesuaikan import jika error

class CustomDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirmDelete;

  const CustomDeleteDialog({
    super.key,
    required this.onConfirmDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF332218),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete Habit?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'The progress this habit cannot\nbe recovered once deleted. 💎',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                // TOMBOL DELETE
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onConfirmDelete();      // Eksekusi fungsi hapus dari parent
                      Navigator.pop(context); // Tutup dialog
                    },
                    child: Container(
                      height: 44, 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE6A84A), width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Color(0xFFE6A84A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // TOMBOL CANCEL
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onTap: () => Navigator.pop(context),
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