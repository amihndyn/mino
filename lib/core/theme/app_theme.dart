import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.coklat900,

    fontFamily: 'Poppins',

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayBold,
      titleLarge: AppTextStyles.pageTitleBold,
      titleMedium: AppTextStyles.sectionTitleBold,
      bodyMedium: AppTextStyles.bodyRegular,
    ),

    colorScheme: ColorScheme.dark(
      primary: AppColors.orange500,
      secondary: AppColors.biru500,
      surface: AppColors.coklat800,
    ),

    useMaterial3: true,
  );
}
