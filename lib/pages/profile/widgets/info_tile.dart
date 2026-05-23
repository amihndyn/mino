import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Container(
        width: double.infinity,
        height: 62,

        padding: const EdgeInsets.symmetric(horizontal: 18),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: const Color(0xFFE6A84A),
            width: 1,
          ),

          color: Colors.black.withOpacity(0.08),
        ),

        child: Row(
          children: [

            Icon(
              icon,
              color: const Color(0xFFE6A84A),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFFF5D2A5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(
              Icons.edit_outlined,
              color: Color(0xFFE6A84A),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}