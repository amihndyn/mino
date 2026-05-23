import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/pages/journal/widgets/journal_card.dart';

import '../../widgets/appbars/custom_appbar.dart';
import '../../widgets/common/section_title.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: const CustomAppBar(
        title: 'My Journal',
        showBackButton: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lg),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SectionTitle(
              title: 'Recent Journal',
            ),

            const SizedBox(height: AppSizes.lg),

            JournalCard
            (
              title: 'Today was productive ✨',
              date: '10 May 2026',

              content:
                  'I finally started building my dream self improvement app and the UI looks aesthetic already.',
            ),

            const SizedBox(height: AppSizes.md),

            JournalCard(
              title: 'Feeling Calm 🌙',
              date: '09 May 2026',

              content:
                  'Today I spent more time focusing on myself and building better habits.',
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange500,

        onPressed: () {},

        child: const Icon(
          Icons.add_rounded,
          color: AppColors.coklat900,
        ),
      ),
    );
  }
}