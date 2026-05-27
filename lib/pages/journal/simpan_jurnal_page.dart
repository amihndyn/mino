// ============================================
// PROGRESS PAGE - PREMIUM DARK UI
// ============================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_sizes.dart';
import 'package:mino/widgets/appbars/custom_appbar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}
 
class _ProgressPageState extends State<ProgressPage> {
  int selectedTab = 1;
  bool isWeekly = true;

  final List<double> weeklyData = [2.2, 1.8, 0.9, 2.0, 1.5, 2.2, 2.2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_dark.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // DARK OVERLAY
          Container(
            color: Colors.black.withValues(alpha: 0.35),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.orange100,
                          size: 20,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        'Progress',
                        style: TextStyle(
                          color: AppColors.orange100,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // TOP TAB
                  _buildTopTab(),

                  const SizedBox(height: 30),

                  // WEEKLY MONTHLY
                  _buildSwitcher(),

                  const SizedBox(height: 26),

                  // GOAL CARD
                  _buildGoalCard(),

                  const SizedBox(height: 26),

                  // ACTIVITY CARD
                  _buildActivityCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================
  // TOP TAB
  // =========================================

  Widget _buildTopTab() {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.coklat900.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.orange700.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          _tabButton(
            title: 'Journal',
            selected: false,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _tabButton(
            title: 'Progress',
            selected: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(
                    colors: [
                      AppColors.orange700,
                      AppColors.orange900,
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected
                  ? AppColors.orange100
                  : AppColors.coklat300,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================
  // SWITCHER
  // =========================================

  Widget _buildSwitcher() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isWeekly = true;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'Weekly',
                      style: TextStyle(
                        color: isWeekly
                            ? AppColors.orange100
                            : AppColors.coklat300,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      color: isWeekly
                          ? AppColors.orange500
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isWeekly = false;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'Monthly',
                      style: TextStyle(
                        color: !isWeekly
                            ? AppColors.orange100
                            : AppColors.coklat300,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      color: !isWeekly
                          ? AppColors.orange500
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        Container(
          height: 1,
          color: AppColors.coklat600,
        ),
      ],
    );
  }

  // =========================================
  // GOAL CARD
  // =========================================

  Widget _buildGoalCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.coklat900.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.orange700.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Goal',
                      style: TextStyle(
                        color: AppColors.coklat300,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "You're getting\ncloser to your\ndiamond.",
                      style: TextStyle(
                        color: AppColors.orange200,
                        fontSize: 18,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              CircularPercentIndicator(
                radius: 42,
                lineWidth: 8,
                percent: 0.84,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AppColors.orange300,
                backgroundColor:
                    AppColors.orange900.withValues(alpha: 0.25),
                center: Text(
                  '84%',
                  style: TextStyle(
                    color: AppColors.orange300,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================
  // ACTIVITY CARD
  // =========================================

  Widget _buildActivityCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.coklat900.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: AppColors.orange700.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Activity',
                style: TextStyle(
                  color: AppColors.orange100,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Your habit consistency\nthis week',
                style: TextStyle(
                  color: AppColors.orange600,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                height: 220,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    weeklyData.length,
                    (index) {
                      final days = [
                        'Sun',
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thur',
                        'Fra',
                        'Sat',
                      ];

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: 28,
                            height: weeklyData[index] * 40,
                            decoration: BoxDecoration(
                              color: AppColors.orange700,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            days[index],
                            style: TextStyle(
                              color: AppColors.orange100,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      );
                    },
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