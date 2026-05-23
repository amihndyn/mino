import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import '../../widgets/appbars/custom_appbar.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/cards/mood_card.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: const CustomAppBar(
        title: 'Mood Tracker',
        showBackButton: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lg),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SectionTitle(
              title: 'Today Mood',
            ),

            const SizedBox(height: AppSizes.lg),

            const MoodCard(
              mood: 'Feeling Great',
              description:
                  'You are doing amazing today ✨',

              emoji: '😊',
            ),

            const SizedBox(height: AppSizes.lg),

            const SectionTitle(
              title: 'Recent Mood',
            ),

            const SizedBox(height: AppSizes.md),

            const MoodCard(
              mood: 'Calm & Relaxed',
              description:
                  'A peaceful and productive day 🌙',

              emoji: '😌',
            ),

            const SizedBox(height: AppSizes.md),

            const MoodCard(
              mood: 'Focused',
              description:
                  'You stayed disciplined today 🔥',

              emoji: '💪',
            ),
          ],
        ),
      ),
    );
  }
}