import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/pages/home/widgets/quick_action.dart';
import 'widgets/greeting_section.dart';
import 'widgets/daily_activity.dart';
import 'widgets/quick_action.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coklat900,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.lg),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // GREETING
              const GreetingSection(),

              const SizedBox(height: AppSizes.lg),

              // ACTIVITY
              const DailyActivity(),

              const SizedBox(height: AppSizes.lg),

              // QUICK ACTION
              const QuickAction(),

              const SizedBox(height: AppSizes.xl),
            ],
          ),
        ),
      ),
    );
  }
}