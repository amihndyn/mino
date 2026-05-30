import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/pages/journal/widgets/journal_banner.dart';
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';
import 'package:mino/pages/journal/note_detail_page.dart';
import 'package:mino/pages/journal/progress_page.dart';

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
      noteTitle: 'Challenging Day',
      noteContent:
          'Today was really tough.\n\nI struggled with staying focused on my tasks. But I learned that it\'s okay to have bad days. Tomorrow is a new opportunity to do better.',
      fullDate: 'Thursday, 30 May 2026',
      moodLabel: 'Bad',
      moodEmoji: '😩',
      moodColor: AppColors.coklat400,
    ),
    JournalEntry(
      dayName: 'Sunday',
      dayNumber: 26,
      noteTitle: 'Amazing Progress',
      noteContent:
          'Had an incredible productive day today!\n\nManaged to complete all my tasks ahead of schedule. Feeling motivated and ready for the week ahead.',
      fullDate: 'Sunday, 26 May 2026',
      moodLabel: 'Amazing',
      moodEmoji: '😁',
      moodColor: AppColors.orange400,
    ),
    JournalEntry(
      dayName: 'Wednesday',
      dayNumber: 15,
      noteTitle: 'Learning New Things',
      noteContent:
          'Started learning Flutter today.\n\nThe journey has been challenging but rewarding. Each line of code brings me closer to building something amazing.',
      fullDate: 'Wednesday, 15 May 2026',
      moodLabel: 'Bad',
      moodEmoji: '😢',
      moodColor: AppColors.coklat400,
    ),
    JournalEntry(
      dayName: 'Saturday',
      dayNumber: 18,
      noteTitle: 'Great Vibes',
      noteContent:
          'Saturday project work went smoothly.\n\nCompleted the design mockups and started implementation. Feeling creative and inspired.',
      fullDate: 'Saturday, 18 May 2026',
      moodLabel: 'Good',
      moodEmoji: '😊',
      moodColor: AppColors.orange500,
    ),
    JournalEntry(
      dayName: 'Monday',
      dayNumber: 12,
      noteTitle: 'Breakthrough Moment',
      noteContent:
          'Finally fixed that tricky bug!\n\nIt took hours of debugging but the satisfaction of solving it was worth every minute. Learning so much every day.',
      fullDate: 'Monday, 12 May 2026',
      moodLabel: 'Amazing',
      moodEmoji: '🤩',
      moodColor: AppColors.orange400,
    ),
    JournalEntry(
      dayName: 'Friday',
      dayNumber: 8,
      noteTitle: 'Steady Progress',
      noteContent:
          'Another week of steady work.\n\nNothing spectacular but consistent progress. Sometimes the quiet days are the most valuable.',
      fullDate: 'Friday, 8 May 2026',
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

      // Navigate to ProgressPage when tab index is 1
      if (index == 1) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProgressPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        ).then((_) {
          // Reset tab when returning from ProgressPage
          setState(() => _tabIndex = 0);
        });
      }
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
            child: Image.asset('assets/images/bg_login.png', fit: BoxFit.cover),
          ),

          // CONTENT
          SafeArea(
            child: Column(
              children: [
                // APPBAR
                const CustomAppBar(title: 'Journal'),

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

                          // BANNER - only in Journal tab
                          if (_tabIndex == 0)
                            const JournalBanner(monthYear: 'April 2026'),

                          if (_tabIndex == 0)
                            const SizedBox(height: AppSizes.md),

                          // CONTENT
                          if (_tabIndex == 0)
                            _buildJournalGrid()
                          else
                            const ProgressPage(),

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
          padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // Kasih jarak antar card
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,

        // KECILIN ratio biar card makin tinggi
        childAspectRatio: 0.58,
      ),
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return JournalCard(
          entry: entry,
          onSeeNote: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetailPage(
                  noteTitle: entry.noteTitle,
                  noteContent: entry.noteContent,
                  fullDate: entry.fullDate,
                  mood: entry.moodEmoji,
                  moodLabel: entry.moodLabel,
                  moodColor: entry.moodColor,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class JournalEntry {
  final String dayName;
  final int dayNumber;
  final String noteTitle;
  final String noteContent;
  final String fullDate;
  final String moodLabel;
  final String moodEmoji;
  final Color moodColor;

  const JournalEntry({
    required this.dayName,
    required this.dayNumber,
    required this.noteTitle,
    required this.noteContent,
    required this.fullDate,
    required this.moodLabel,
    required this.moodEmoji,
    required this.moodColor,
  });
}
