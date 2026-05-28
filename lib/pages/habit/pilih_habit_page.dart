import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

import '../../providers/habit_provider.dart';

import 'widgets/add_habit_header.dart';
import 'widgets/habit_section.dart';
import 'widgets/unique_habit_card.dart';

class PilihHabitPage extends StatelessWidget {
  const PilihHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HabitProvider(),

      child: Consumer<HabitProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: AppColors.coklat700,

            body: SafeArea(
              child: Column(
                children: [
                  const Spacer(),

                  Expanded(
                    flex: 14,

                    child: Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),

                      decoration: const BoxDecoration(
                        color: AppColors.orange100,

                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),

                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            /// HEADER
                            const AddHabitHeader(),

                            const SizedBox(height: 28),

                            /// TITLE
                            Text(
                              "Let’s discover\nyour new habits",
                              style: AppTextStyles
                                  .pageTitleBold
                                  .copyWith(
                                color: AppColors.coklat700,
                                height: 1.2,
                              ),
                            ),

                            const SizedBox(height: 10),

                            /// SUBTITLE
                            Text(
                              "Choose one habit, then tap Next",
                              style: AppTextStyles.bodyRegular
                                  .copyWith(
                                color: AppColors.coklat500,
                              ),
                            ),

                            const SizedBox(height: 30),

                            /// UNIQUE HABIT
                            Text(
                              "Be unique",
                              style: AppTextStyles
                                  .sectionTitleBold
                                  .copyWith(
                                color: AppColors.coklat700,
                              ),
                            ),

                            const SizedBox(height: 12),

                            const UniqueHabitCard(),

                            const SizedBox(height: 32),

                            /// SECTIONS
                            ...provider.sections.entries.map(
                              (section) => Padding(
                                padding:
                                    const EdgeInsets.only(
                                  bottom: 28,
                                ),

                                child: HabitSection(
                                  title: section.key,

                                  habits: section.value,

                                  selectedHabit:
                                      provider.selectedHabit,

                                  onSelect: (value) {
                                    provider.selectHabit(
                                      value,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}