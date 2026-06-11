import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/providers/journal_provider.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/pages/journal/widgets/period_switcher.dart'; 
import 'package:mino/pages/journal/widgets/journal_card.dart';
import 'package:mino/pages/journal/note_detail_page.dart';

class JournalPage extends StatefulWidget {
  final int currentTabIndex;
  final ValueChanged<int> onTabChanged;

  const JournalPage({
    super.key,
    required this.currentTabIndex,
    required this.onTabChanged,
  });

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  bool _isWeekly = true; 
  final String _selectedMonth = "June"; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<JournalProvider>().fetchJournals();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================================
        // 1. BAGIAN ATAS (FIXED / TIDAK IKUT SCROLL)
        // ==========================================
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 32, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Journal',
                style: TextStyle(
                  color: AppColors.orange100,
                  fontSize: 28, 
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1
                ),
              ),
              const SizedBox(height: AppSizes.md),
              
              JournalTabSwitch(
                selectedIndex: widget.currentTabIndex,
                onChanged: widget.onTabChanged,
              ),
              const SizedBox(height: 26),
              
              // PERBAIKAN: Menambahkan parameter isWeekly yang required
              PeriodSwitcher(
                isWeekly: _isWeekly, 
                onChanged: (val) {
                  setState(() {
                    _isWeekly = val;
                  });
                },
              ),
            ],
          ),
        ),

        // ==========================================
        // 2. BAGIAN BAWAH (SCROLLABLE LIST)
        // ==========================================
        Expanded(
          child: ClipRect(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.md),
                  
                  Consumer<JournalProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.orange400,
                            ),
                          ),
                        );
                      }

                      if (provider.journals.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              'No journal entries today.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }

                      final entries = provider.journals;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // LIST JURNAL VERTIKAL
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: entries.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final entry = entries[index];
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
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}