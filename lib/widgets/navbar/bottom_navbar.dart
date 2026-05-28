import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: const Color(0xff3A2417),

        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            icon: Icons.home,
            label: "Home",
            index: 0,
          ),

          _buildItem(
            icon: Icons.menu_book,
            label: "Journal",
            index: 1,
          ),

          _buildItem(
            icon: Icons.emoji_events,
            label: "Challenge",
            index: 2,
          ),

          _buildItem(
            icon: Icons.person,
            label: "Profile",
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isActive =
        currentIndex == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive
              ? const Color(0xffE6A84A)
              : Colors.white54,
        ),

        const SizedBox(height: 6),

        Text(
          label,
          style: TextStyle(
            color: isActive
                ? const Color(0xffE6A84A)
                : Colors.white54,

            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}