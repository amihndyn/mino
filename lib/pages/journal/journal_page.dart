import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/pages/journal/widgets/journal_banner.dart';
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';
import 'package:mino/pages/journal/simpan_jurnal_page.dart'; // sesuaikan path-nya

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  int _navIndex = 1;
  late AnimationController _fadeController;

  final List<JournalEntry> _entries = [
    JournalEntry(
      dayName: 'Thursday',
      dayNumber: 30,
      moodLabel: 'Bad',
      moodEmoji: '😩',
      moodColor: AppColors.coklat400,
    ),
    JournalEntry(
      dayName: 'Sunday',
      dayNumber: 26,
      moodLabel: 'Amazing',
      moodEmoji: '😁',
      moodColor: AppColors.orange400,
    ),
    JournalEntry(
      dayName: 'Wednesday',
      dayNumber: 15,
      moodLabel: 'Bad',
      moodEmoji: '😢',
      moodColor: AppColors.coklat400,
    ),
    JournalEntry(
      dayName: 'Saturday',
      dayNumber: 18,
      moodLabel: 'Good',
      moodEmoji: '😊',
      moodColor: AppColors.orange500,
    ),
    JournalEntry(
      dayName: 'Monday',
      dayNumber: 12,
      moodLabel: 'Amazing',
      moodEmoji: '🤩',
      moodColor: AppColors.orange400,
    ),
    JournalEntry(
      dayName: 'Friday',
      dayNumber: 8,
      moodLabel: 'Okay',
      moodEmoji: '😐',
      moodColor: AppColors.orange300,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    _fadeController.reverse().then((_) {
      setState(() => _tabIndex = index);
      _fadeController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // BACKGROUND
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_login.png',
              fit: BoxFit.cover,
            ),
          ),

          // CONTENT
          SafeArea(
            child: Column(
              children: [
                // APPBAR
                  const CustomAppBar(
                    title: 'Journal',
                  ),

                // SCROLLABLE CONTENT
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeController,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.md,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSizes.md),

                          // TAB SWITCH
                          JournalTabSwitch(
                            selectedIndex: _tabIndex,
                            onChanged: _onTabChanged,
                          ),

                          const SizedBox(height: AppSizes.md),

                          // BANNER
                          const JournalBanner(monthYear: 'April 2026'),

                          const SizedBox(height: AppSizes.md),

                          // CONTENT
                          if (_tabIndex == 0)
                            _buildJournalGrid()
                          else
                            _buildProgressPlaceholder(),

                          const SizedBox(height: AppSizes.xl),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
        crossAxisSpacing: AppSizes.md,
        mainAxisSpacing: AppSizes.md,
        childAspectRatio: 0.75,
      ),
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return JournalCard(
          entry: entry,
          onSeeNote: () {
            // Navigate to journal detail
          },
        );
      },
    );
  }

Widget _buildProgressPlaceholder() {
  return const ProgressPage();
}
}

class JournalEntry {
  final String dayName;
  final int dayNumber;
  final String moodLabel;
  final String moodEmoji;
  final Color moodColor;

  const JournalEntry({
    required this.dayName,
    required this.dayNumber,
    required this.moodLabel,
    required this.moodEmoji,
    required this.moodColor,
  });
}
