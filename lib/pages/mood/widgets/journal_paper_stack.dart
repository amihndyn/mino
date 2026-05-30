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
      children: [
        // Kertas belakang (efek tumpukan paling bawah)
        Positioned(
          top: 8,
          left: 10,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0DFC0),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        
        // Kertas belakang kedua (lapisan tengah)
        Positioned(
          top: 4,
          left: 5,
          right: 5,
          bottom: 4,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5E8D0),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        
        // Kertas utama (area tulis paling atas)
        Container(
          margin: const EdgeInsets.only(right: 10, bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF0DC),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
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
              fontSize: 15,
              height: 1.7,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter topic',
              hintStyle: TextStyle(
                color: Color(0xFFB8956A),
                fontSize: 15,
              ),
              contentPadding: EdgeInsets.all(20),
              border: InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}