import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  // Menyimpan daftar habit yang dicentang oleh user saat memilih
  final List<String> _selectedHabits = [];
  List<String> get selectedHabits => _selectedHabits;

  // ── 1. MASTER TEMPLATE DEFAULT ──
  final Map<String, List<Map<String, dynamic>>> sections = {
    "Practice self-care": [
      {"title": "Cold shower", "icon": "assets/images/shower.png"},
      {"title": "Hair care", "icon": "assets/images/hair.png"},
    ],
    "Become active": [
      {"title": "Practice yoga", "icon": "assets/images/yoga.png"},
      {"title": "Gym workout", "icon": "assets/images/gym.png"},
      {"title": "Walk 10,000 steps", "icon": "assets/images/walk.png"},
      {"title": "Pilates class", "icon": "assets/images/pilates.png"},
    ],
    "Start living healthier": [
      {"title": "Wake up early", "icon": "assets/images/wakeUp.png"},
      {"title": "Drink water", "icon": "assets/images/water.png"},
      {"title": "Take vitamin", "icon": "assets/images/vitamin.png"},
      {"title": "Eat fruit", "icon": "assets/images/fruits.png"},
      {"title": "Eat vegetables", "icon": "assets/images/salad.png"},
      {"title": "Sunbathe", "icon": "assets/images/sunbathe.png"},
    ],
    "Practice mindfulness": [
      {"title": "Morning meditation", "icon": "assets/images/meditation.png"},
      {"title": "Pray before sleeping", "icon": "assets/images/pray.png"},
    ],
    "Study": [
      {"title": "Read a book", "icon": "assets/images/read.png"},
      {"title": "Learn new skills", "icon": "assets/images/learn.png"},
      {"title": "Take an English course", "icon": "assets/images/course.png"},
    ],
    "Do homework": [
      {"title": "Sweep", "icon": "assets/images/sweep.png"},
      {"title": "Wash dishes", "icon": "assets/images/wash_dishes.png"},
      {"title": "Wash clothes", "icon": "assets/images/wash_clothes.png"},
      {"title": "Make the bed", "icon": "assets/images/bed.png"},
    ],
  };

  // ── 2. DYNAMIC ICON HELPER ──
  String? getIconPath(String habitName) {
    for (var category in sections.values) {
      for (var habit in category) {
        if (habit["title"].toString().toLowerCase() == habitName.toLowerCase()) {
          return habit["icon"];
        }
      }
    }
    return null; 
  }

  // ── 3. FUNGSI MANAJEMEN STATE ──
  void toggleHabit(String habit) {
    if (_selectedHabits.contains(habit)) {
      _selectedHabits.remove(habit);
    } else {
      _selectedHabits.add(habit);
    }
    notifyListeners();
  }

  void clearSelectedHabits() {
    _selectedHabits.clear();
    notifyListeners();
  }

  // 🔥 FUNGSI BARU: Validasi apakah habit sudah ada di dashboard hari ini
  // Parameter 'existingHabitNames' dikirim dari UI (mengambil daftar nama dari DashboardBloc)
  bool isHabitAlreadyExists(String habitName, List<String> existingHabitNames) {
    return existingHabitNames.any(
      (existingName) => existingName.trim().toLowerCase() == habitName.trim().toLowerCase()
    );
  }
}