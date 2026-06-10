import 'package:flutter/material.dart';

class PomodoroTabMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const PomodoroTabMenu({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTab(
            index: 0,
            label: 'Challenge',
            assetPath: 'assets/images/challenge.png',
          ),

          _buildTab(
            index: 1,
            label: 'Timer',
            assetPath: 'assets/images/timer.png',
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required int index,
    required String label,
    required String assetPath,
  }) {
    final bool isSelected = selectedIndex == index;

    const Color themeGold = Color(0xffF2CD94);

    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.12)
              : Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? themeGold.withOpacity(0.8)
                : Colors.white10,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Opacity(
              opacity: isSelected ? 1.0 : 0.4,
              child: Image.asset(
                assetPath,
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Colors.white70,
                fontSize: 14,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}