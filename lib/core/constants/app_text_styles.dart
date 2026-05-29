import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  // DISPLAY
  static const displayBold = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.orange100,
  );

  static const displaySemiBold = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.orange100,
  );

  // PAGE TITLE
  static const pageTitleBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.orange100,
  );

  static const pageTitleSemiBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.orange100,
  );

  // SECTION TITLE
  static const sectionTitleBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.orange100,
  );

  // BODY
  static const bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.orange100,
  );

  static const bodyRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.orange100,
  );

  // SECONDARY
  static const secondaryMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  );

  // CAPTION
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.grey,
  );

  // =========================================================
  // HABIT PAGE
  // =========================================================

  static const habitHeading = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: AppColors.black,
    height: 1.2,
  );

  static const habitSubHeading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.habitTextSecondary,
  );

  static const habitSectionTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const habitCardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static const habitHeader = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const habitCancel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.habitTextSecondary,
  );
}