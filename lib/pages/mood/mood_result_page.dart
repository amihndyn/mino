import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class MoodResultPage
    extends StatelessWidget {
  final String mood;
  final String emoji;
  final String message;

  const MoodResultPage({
    super.key,
    required this.mood,
    required this.emoji,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            AppSizes.xl,
          ),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              Text(
                emoji,
                style: const TextStyle(
                  fontSize: 90,
                ),
              ),

              const SizedBox(
                height: AppSizes.xl,
              ),

              Text(
                mood,

                style: AppTextStyles
                    .pageTitleBold,
              ),

              const SizedBox(
                height: AppSizes.md,
              ),

              Text(
                message,

                textAlign: TextAlign.center,

                style: AppTextStyles
                    .secondaryMedium
                    .copyWith(
                  height: 1.7,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },

                child: Container(
                  width: double.infinity,
                  height: 58,

                  decoration: BoxDecoration(
                    color:
                        AppColors.orange500,

                    borderRadius:
                        BorderRadius.circular(
                      AppSizes.radiusLg,
                    ),
                  ),

                  alignment: Alignment.center,

                  child: Text(
                    'Back',

                    style: AppTextStyles
                        .bodyMedium
                        .copyWith(
                      color:
                          AppColors
                              .coklat900,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}