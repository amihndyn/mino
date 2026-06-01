import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  // Menyimpan daftar habit yang dipilih oleh pengguna
  final List<String> _selectedHabits = [];

  // Getter agar data list tidak bisa dimanipulasi langsung dari luar tanpa melalui fungsi resmi
  List<String> get selectedHabits => _selectedHabits;

  // ── STRUKTUR DATA SECTIONS (Migrasi Penuh ke .svg) ──────────────────
  final Map<String, List<Map<String, dynamic>>> sections = {
    "Practice self-care": [
      {
        "title": "Cold shower",
        "icon": "assets/images/shower.svg",
      },
      {
        "title": "Hair care",
        "icon": "assets/images/hair.svg",
      },
    ],
    "Become active": [
      {
        "title": "Practice yoga",
        "icon": "assets/images/yoga.svg",
      },
      {
        "title": "Gym workout",
        "icon": "assets/images/gym.svg",
      },
      {
        "title": "Walk 10,000 steps",
        "icon": "assets/images/walk.svg",
      },
      {
        "title": "Pilates class",
        "icon": "assets/images/pilates.svg",
      },
    ],
    "Start living healthier": [
      {
        "title": "Wake up early",
        "icon": "assets/images/wakeUp.svg",
      },
      {
        "title": "Drink water",
        "icon": "assets/images/drink.svg",
      },
      {
        "title": "Take vitamin",
        "icon": "assets/images/vitamin.svg",
      },
      {
        "title": "Eat fruit",
        "icon": "assets/images/fruits.svg",
      },
      {
        "title": "Eat vegetables",
        "icon": "assets/images/salad.svg",
      },
      {
        "title": "Sunbathe",
        "icon": "assets/images/sunbathe.svg",
      },
    ],
    "Practice mindfulness": [
      {
        "title": "Morning meditation",
        "icon": "assets/images/meditation.svg",
      },
      {
        "title": "Pray before sleeping",
        "icon": "assets/images/pray.svg", 
      },
    ],
    "Study": [
      {
        "title": "Read a book",
        "icon": "assets/images/read.svg",
      },
      {
        "title": "Learn new skills",
        "icon": "assets/images/learn.svg",
      },
      {
        "title": "Take an English course",
        "icon": "assets/images/course.svg",
      },
    ],
    "Do homework": [
      {
        "title": "Sweep",
        "icon": "assets/images/sweep.svg",
      },
      {
        "title": "Wash dishes",
        "icon": "assets/images/wash_dishes.svg",
      },
      {
        "title": "Wash clothes",
        "icon": "assets/images/wash_clothes.svg",
      },
      {
        "title": "Make the bed",
        "icon": "assets/images/bed.svg",
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