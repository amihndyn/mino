import 'package:flutter/material.dart';

class JournalTabSwitch extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const JournalTabSwitch({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab(
          index: 0,
          title: 'Journal',
        ),

        const SizedBox(width: 12),

        _buildTab(
          index: 1,
          title: 'Progress',
        ),
      ],
    );
  }

  Widget _buildTab({
    required int index,
    required String title,
  }) {
    final bool isActive =
        selectedIndex == index;

    return GestureDetector(
      onTap: () => onChanged(index),

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isActive
              ? Colors.orange
              : Colors.white24,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive
                ? Colors.white
                : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}