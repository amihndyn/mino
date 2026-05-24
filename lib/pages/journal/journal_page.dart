import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';

import 'widgets/journal_banner.dart';
import 'widgets/journal_card.dart';
import 'widgets/journal_tab_switch.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  int _tabIndex = 0;
  int _navIndex = 1;

  // Sample data — replace with real data source later
  final List<Map<String, dynamic>> _entries = [
    {
      'dayName': 'Thursday',
      'dayNumber': 30,
      'moodLabel': 'Bad',
      'moodEmoji': '😩',
      'moodColor': AppColors.coklat300,
    },
    {
      'dayName': 'Sunday',
      'dayNumber': 26,
      'moodLabel': 'Amazing',
      'moodEmoji': '😁',
      'moodColor': AppColors.orange400,
    },
    {
      'dayName': 'Wednesday',
      'dayNumber': 15,
      'moodLabel': 'Bad',
      'moodEmoji': '😢',
      'moodColor': AppColors.coklat300,
    },
    {
      'dayName': 'Saturday',
      'dayNumber': 18,
      'moodLabel': 'Good',
      'moodEmoji': '😊',
      'moodColor': AppColors.orange300,
    },
    {
      'dayName': 'Monday',
      'dayNumber': 12,
      'moodLabel': 'Amazing',
      'moodEmoji': '🤩',
      'moodColor': AppColors.orange400,
    },
    {
      'dayName': 'Friday',
      'dayNumber': 8,
      'moodLabel': 'Okay',
      'moodEmoji': '😐',
      'moodColor': AppColors.coklat200,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,
      appBar: const CustomAppBar(title: 'Jurnal', showBackButton: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab switch
                  JournalTabSwitch(
                    selectedIndex: _tabIndex,
                    onChanged: (i) => setState(() => _tabIndex = i),
                  ),

                  const SizedBox(height: AppSizes.md),

                  // Banner
                  const JournalBanner(monthYear: 'April 2026'),

                  const SizedBox(height: AppSizes.md),

                  // Journal grid
                  if (_tabIndex == 0) _buildJournalGrid(),
                  if (_tabIndex == 1) _buildProgressPlaceholder(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }

  Widget _buildJournalGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.sm,
        mainAxisSpacing: AppSizes.sm,
        childAspectRatio: 0.72,
      ),
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return JournalCard(
          dayName: entry['dayName'],
          dayNumber: entry['dayNumber'],
          moodLabel: entry['moodLabel'],
          moodEmoji: entry['moodEmoji'],
          moodColor: entry['moodColor'],
          onSeeNote: () {},
        );
      },
    );
  }

  Widget _buildProgressPlaceholder() {
    return const SizedBox(
      height: 300,
      child: Center(
        child: Text(
          'Progress coming soon...',
          style: TextStyle(color: AppColors.coklat300),
        ),
      ),
    );
  }
}
