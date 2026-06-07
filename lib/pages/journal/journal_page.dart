import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/providers/journal_provider.dart';
import 'package:mino/pages/journal/widgets/journal_banner.dart';
import 'package:mino/pages/journal/widgets/journal_grid.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';

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
        // 1. BAGIAN ATAS (FIXED / TIDAK IKUT SCROLL)
        Padding(
          // --- PADDING DITAMBAHKAN DI SINI (bottom: 15) ---
          padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
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
            ],
          ),
        ),

        // 2. BAGIAN BAWAH (BISA DI-SCROLL)
        Expanded(
          child: ClipRect(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              // --- PADDING ATAS BAWAH KONTEN SCROLL DISESUAIKAN ---
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner tetap ikut ter-scroll
                  const JournalBanner(monthYear: 'April 2026'), 
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

                      return JournalGrid(entries: provider.journals);
                    },
                  ),
                  
                  // Jarak ekstra di ujung bawah agar konten paling bawah tidak terhalang navbar
                  const SizedBox(height: 130), 
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}