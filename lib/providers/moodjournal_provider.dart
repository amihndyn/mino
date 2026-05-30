import 'package:flutter/material.dart';

class MoodJournalProvider extends ChangeNotifier {
  String? _selectedMood;
  String? _writtenNote;

  String? get selectedMood => _selectedMood;
  String? get writtenNote => _writtenNote;

  // Fungsi untuk set mood dari MoodPage
  void setMood(String mood) {
    _selectedMood = mood;
    notifyListeners(); // Memberitahu widget lain kalau ada perubahan data
  }

  // Fungsi untuk set catatan dari WriteJournalScreen
  void setNote(String note) {
    _writtenNote = note;
    notifyListeners();
  }

  // Fungsi untuk reset data (jika nanti dibutuhkan saat logout/clear)
  void reset() {
    _selectedMood = null;
    _writtenNote = null;
    notifyListeners();
  }
}