import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/core/constants/app_text_styles.dart';

import 'widgets/challenge_banner.dart';
import 'widgets/challenge_info.dart';

class ChallengeDetailPage
    extends StatelessWidget {
  const ChallengeDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppSizes.lg,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const ChallengeBanner(
              title: '30 Days Healthy Challenge', 
              subtitle: 'Build better habits everyday'),

            const SizedBox(
              height: AppSizes.xl,
            ),

            Text(
              '30 Days Healthy Challenge',

              style: AppTextStyles
                  .pageTitleBold,
            ),

            const SizedBox(
              height: AppSizes.md,
            ),

            Text(
              'Build better habits and improve your daily lifestyle with simple consistent activities.',

              style: AppTextStyles
                  .secondaryMedium
                  .copyWith(
                height: 1.7,
              ),
            ),

            const SizedBox(
              height: AppSizes.xl,
            ),

            const ChallengeInfo(
              icon: Icons.calendar_month,
              title: 'Duration',
              value: '30 Days',
            ),

            const SizedBox(
              height: AppSizes.md,
            ),

            const ChallengeInfo(
              icon: Icons.local_fire_department,
              title: 'Difficulty',
              value: 'Medium',
            ),

            const SizedBox(
              height: 50,
            ),

            GestureDetector(
              onTap: () {},

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
                  'Join Challenge',

                  style: AppTextStyles
                      .bodyMedium
                      .copyWith(
                    color:
                        AppColors.coklat900,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}