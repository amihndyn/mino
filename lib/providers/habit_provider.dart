import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  List<String> selectedHabits = [];

  final Map<String, List<Map<String, dynamic>>> sections = {
    "Practice self-care": [
      {
        "title": "Cold shower",
        "icon": "assets/images/shower.png",
      },
      {
        "title": "Hair care",
        "icon": "assets/images/hair.png",
      },
    ],
    "Become active": [
      {
        "title": "Practice yoga",
        "icon": "assets/images/yoga.png",
      },
      {
        "title": "Gym workout",
        "icon": "assets/images/gym.png",
      },
      {
        "title": "Walk 10,000 steps",
        "icon": "assets/images/walk.png",
      },
      {
        "title": "Pilates class",
        "icon": "assets/images/pilates.png",
      },
    ],
    "Start living healthier": [
      {
        "title": "Wake up early",
        "icon": "assets/images/wakeUp.png",
      },
      {
        "title": "Drink water",
        "icon": "assets/images/drink.png",
      },
      {
        "title": "Take vitamin",
        "icon": "assets/images/vitamin.png",
      },
      {
        "title": "Eat fruit",
        "icon": "assets/images/fruits.png",
      },
      {
        "title": "Eat vegetables",
        "icon": "assets/images/salad.png",
      },
      {
        "title": "Sunbathe",
        "icon": "assets/images/sunbathe.png",
      },
    ],
    "Practice mindfulness": [
      {
        "title": "Morning meditation",
        "icon": "assets/images/meditation.png",
      },
      // --- Lanjutan dari gambar desain ---
      {
        "title": "Pray before sleeping",
        "icon": "assets/images/pray.png", 
      },
    ],
    "Study": [
      {
        "title": "Read a book",
        "icon": "assets/images/read.png",
      },
      {
        "title": "Learn new skills",
        "icon": "assets/images/learn.png",
      },
      {
        "title": "Take an English course",
        "icon": "assets/images/course.png",
      },
    ],
    "Do homework": [
      {
        "title": "Sweep",
        "icon": "assets/images/sweep.png",
      },
      {
        "title": "Wash dishes",
        "icon": "assets/images/wash_dishes.png",
      },
      {
        "title": "Wash clothes",
        "icon": "assets/images/wash_clothes.png",
      },
      {
        "title": "Make the bed",
        "icon": "assets/images/bed.png",
      },
    ],
  };

  void toggleHabit(String habit) {
    if (selectedHabits.contains(habit)) {
      selectedHabits.remove(habit); // Batal pilih
    } else {
      selectedHabits.add(habit); // Pilih
    }
    notifyListeners();
  }
}