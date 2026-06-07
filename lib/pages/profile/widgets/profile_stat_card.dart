import 'package:flutter/material.dart';

class ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        color: const Color(0xFF2B1D19).withOpacity(0.88),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 20,
          ),
        ],
      ),

      padding: const EdgeInsets.all(18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.06),
            ),

            child: Icon(
              icon,
              color: iconColor,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF7EFE7),
              letterSpacing: 1
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF9F8572),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}