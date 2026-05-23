import 'package:flutter/material.dart';
import 'package:mino/core/constants/app_colors.dart';
import 'package:mino/core/constants/app_text_styles.dart';

class TimerClock extends StatelessWidget {
  final String time;

  const TimerClock({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 260,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            AppColors.orange700,
            AppColors.coklat700,
          ],
        ),

        boxShadow: [
          BoxShadow(
            color:
                AppColors.orange500.withOpacity(
              0.18,
            ),

            blurRadius: 40,
            spreadRadius: 3,
          ),
        ],
      ),

      alignment: Alignment.center,

      child: Text(
        time,

        style:
            AppTextStyles.displayBold.copyWith(
          fontSize: 52,
        ),
      ),
    );
  }
}