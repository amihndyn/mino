import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  // Menyimpan daftar habit yang dipilih oleh pengguna
  final List<String> _selectedHabits = [];

  // Getter agar data list tidak bisa dimanipulasi langsung dari luar tanpa melalui fungsi resmi
  List<String> get selectedHabits => _selectedHabits;

  // ── STRUKTUR DATA SECTIONS (Migrasi Penuh ke .png) ──────────────────
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

  // ── FUNGSI MANAJEMEN STATE ──────────────────────────────────────────

  // Menambah atau menghapus habit yang dipilih
  void toggleHabit(String habit) {
    if (_selectedHabits.contains(habit)) {
      _selectedHabits.remove(habit); // Batal pilih jika sudah ada
    } else {
      _selectedHabits.add(habit); // Pilih jika belum ada
    }
    notifyListeners(); // Memicu UI untuk merendering ulang bagian yang diconsume
  }

  // Fungsi helper untuk mengecek apakah sebuah habit sedang dipilih (berguna untuk styling border/warna di UI)
  bool isHabitSelected(String habit) {
    return _selectedHabits.contains(habit);
  }

  // Fungsi untuk mereset semua pilihan (misal ketika user membatalkan seluruh proses setup)
  void clearSelectedHabits() {
    _selectedHabits.clear();
    notifyListeners();
  }
}