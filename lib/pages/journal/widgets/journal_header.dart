import 'package:flutter/material.dart';

class JournalHeader extends StatelessWidget {
  final int currentTabIndex;
  final ValueChanged<int> onTabChanged;

  const JournalHeader({
    super.key,
    required this.currentTabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Baris Tombol Back & Judul Halaman
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFFE6A84A), size: 22),
              onPressed: () => Navigator.maybePop(context),
            ),
            const Text(
              "Notes",
              style: TextStyle(
                color: Color(0xFFE6A84A),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Custom Tab Switcher (Journal vs Progress)
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF2B1E16), // Latar dalam gelap
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF59463D), width: 1),
          ),
          child: Row(
            children: [
              // Tab Journal
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: currentTabIndex == 0 ? const Color(0xFF59463D) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Journal",
                      style: TextStyle(
                        color: const Color(0xFFE6A84A),
                        fontSize: 15,
                        fontWeight: currentTabIndex == 0 ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              // Tab Progress
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged(1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: currentTabIndex == 1 ? const Color(0xFF59463D) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Progress",
                      style: TextStyle(
                        color: const Color(0xFFE6A84A),
                        fontSize: 15,
                        fontWeight: currentTabIndex == 1 ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}