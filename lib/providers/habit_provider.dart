import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  String? selectedHabit;

  final Map<String, List<Map<String, dynamic>>> sections = {
    "Practice self-care": [
      {
        "title": "Cold shower",
        "icon": Icons.ac_unit,
      },
      {
        "title": "Hair care",
        "icon": Icons.spa,
      },
    ],

    "Become active": [
      {
        "title": "Practice yoga",
        "icon": Icons.self_improvement,
      },
      {
        "title": "Gym workout",
        "icon": Icons.fitness_center,
      },
      {
        "title": "Walk 10,000 steps",
        "icon": Icons.directions_walk,
      },
      {
        "title": "Pilates class",
        "icon": Icons.accessibility_new,
      },
    ],

    "Start living healthier": [
      {
        "title": "Wake up early",
        "icon": Icons.wb_sunny_outlined,
      },
      {
        "title": "Drink water",
        "icon": Icons.water_drop_outlined,
      },
      {
        "title": "Take vitamin",
        "icon": Icons.medication_outlined,
      },
      {
        "title": "Eat fruit",
        "icon": Icons.apple,
      },
      {
        "title": "Eat vegetables",
        "icon": Icons.eco_outlined,
      },
      {
        "title": "Sunbathe",
        "icon": Icons.wb_sunny,
      },
    ],

    "Practice mindfulness": [
      {
        "title": "Morning meditation",
        "icon": Icons.air,
      },
    ],
  };

  void selectHabit(String habit) {
    selectedHabit = habit;
    notifyListeners();
  }
}