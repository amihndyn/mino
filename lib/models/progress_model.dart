import 'package:flutter/material.dart';

class MonthData {
  final String month;
  final double goalPercent;
  final List<double> weeklyBars;

  MonthData({
    required this.month,
    required this.goalPercent,
    required this.weeklyBars,
  });
}

class StatData {
  final String label;
  final String value;
  final IconData? icon;

  StatData({required this.label, required this.value, this.icon});
}

class AchievementData {
  final String emoji;
  final String title;

  AchievementData({required this.emoji, required this.title});
}