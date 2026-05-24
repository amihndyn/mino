import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/pages/journal/widgets/journal_banner.dart';
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/widgets/navbar/bottom_navbar.dart';

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
                _buildAppBar(),

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

  Widget _buildAppBar() {
    return Container(
      height: AppSizes.appBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.coklat900.withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(
            color: AppColors.coklat700.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.coklat800.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                border: Border.all(
                  color: AppColors.coklat600,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chevron_left_rounded,
                color: AppColors.orange200,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Text(
              'Journal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.orange100,
                shadows: [
                  Shadow(
                    color: AppColors.orange500.withValues(alpha: 0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
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
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.coklat800.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(
          color: AppColors.orange900.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 48,
              color: AppColors.orange400.withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppSizes.md),
            Text(
              'Progress coming soon...',
              style: TextStyle(
                color: AppColors.orange200.withValues(alpha: 0.8),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
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
