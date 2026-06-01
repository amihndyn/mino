import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Tambahkan import ini

class JournalWritingView extends StatelessWidget {
  final TextEditingController noteController;
  final VoidCallback onClose;
  final VoidCallback onSave;

  const JournalWritingView({
    super.key,
    required this.noteController,
    required this.onClose,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // Diubah ke SVG menggunakan SvgPicture.asset
            SvgPicture.asset(
              'assets/images/blogjurnal.svg', 
              height: 40,
            ),
            const SizedBox(width: 12),
            const Text(
              "Today's note",
              style: TextStyle(
                color: Color(0xFF2A1A0E),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onClose,
              child: const Icon(
                Icons.close,
                color: Color(0xFF7A5C3E),
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(color: Color(0xFFD4B896), thickness: 1),
        const SizedBox(height: 12),
        TextField(
          controller: noteController,
          maxLines: 8,
          minLines: 5,
          style: const TextStyle(
            color: Color(0xFF2A1A0E),
            fontSize: 14,
            height: 1.6,
          ),
          decoration: const InputDecoration(
            hintText: 'Write what you feel today...',
            hintStyle: TextStyle(color: Color(0xFFB09070), fontSize: 14),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: onSave,
            child: const Text(
              'Save note',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}