import 'package:flutter/material.dart';

class ActivityItemCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ActivityItemCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xffE6A84A),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xff59463D),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xff59463D),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const Icon(
            Icons.check_circle_outline,
            color: Color(0xff59463D),
          ),
        ],
      ),
    );
  }
}