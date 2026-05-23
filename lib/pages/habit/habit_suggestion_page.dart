import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import '../../widgets/cards/habit_card.dart';

class HabitSuggestionPage
    extends StatelessWidget {
  const HabitSuggestionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      {
        'title': 'Drink Water',
        'subtitle':
            'Drink 8 glasses everyday',
        'image':
            'assets/images/water.png',
      },
      {
        'title': 'Morning Yoga',
        'subtitle':
            '15 minutes every morning',
        'image':
            'assets/images/yoga.png',
      },
      {
        'title': 'Reading',
        'subtitle':
            'Read 10 pages daily',
        'image':
            'assets/images/book.png',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Habit Suggestions',

          style:
              AppTextStyles.pageTitleBold,
        ),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        itemCount: suggestions.length,

        separatorBuilder: (_, __) =>
            const SizedBox(
          height: AppSizes.md,
        ),

        itemBuilder: (context, index) {
          final item =
              suggestions[index];

          return HabitCard(
            title: item['title']!,
            subtitle:
                item['subtitle']!,
            image: item['image']!,
          );
        },
      ),
    );
  }
}