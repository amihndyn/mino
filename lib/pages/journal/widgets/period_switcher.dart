import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';

class PeriodSwitcher extends StatelessWidget {
  final bool isWeekly;
  final Function(bool) onChanged;

  const PeriodSwitcher({
    super.key,
    required this.isWeekly,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(true),
                child: Column(
                  children: [
                    Text(
                      'Weekly',
                      style: TextStyle(
                        color: isWeekly ? AppColors.orange100 : AppColors.coklat300,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      width: double.infinity,
                      color: isWeekly ? AppColors.orange500 : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(false),
                child: Column(
                  children: [
                    Text(
                      'Monthly',
                      style: TextStyle(
                        color: !isWeekly ? AppColors.orange100 : AppColors.coklat300,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 3,
                      width: double.infinity,
                      color: !isWeekly ? AppColors.orange500 : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(height: 1, color: AppColors.coklat600),
      ],
    );
  }
}