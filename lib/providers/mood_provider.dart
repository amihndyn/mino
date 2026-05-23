import 'package:flutter/material.dart';

import '../models/mood_model.dart';

class MoodProvider extends ChangeNotifier {
  final List<MoodModel> _moods = [];

  List<MoodModel> get moods => _moods;

  // ADD
  void addMood(MoodModel mood) {
    _moods.add(mood);
    notifyListeners();
  }

  // DELETE
  void deleteMood(String id) {
    _moods.removeWhere(
      (mood) => mood.id == id,
    );

    notifyListeners();
  }
}