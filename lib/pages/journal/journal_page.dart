import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/providers/journal_provider.dart';
import 'package:mino/pages/journal/widgets/journal_banner.dart';
import 'package:mino/pages/journal/widgets/journal_grid.dart';
import 'package:mino/pages/journal/widgets/journal_tab_switch.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';

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
      children: [
        const CustomAppBar(title: 'Journal'),
        Expanded(
          // 1. Tambahkan ClipRect agar widget anak tidak meluap keluar dari batas Expanded ini
          child: ClipRect(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.md),
                  JournalTabSwitch(
                    selectedIndex: widget.currentTabIndex,
                    onChanged: widget.onTabChanged,
                  ),
                  const SizedBox(height: AppSizes.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                  // 2. Jarak ekstra di ujung bawah agar konten paling bawah tidak terhalang navbar
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