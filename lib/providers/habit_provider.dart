import 'package:flutter/material.dart';

import '../models/habit_model.dart';

class HabitProvider extends ChangeNotifier {
  final List<HabitModel> _habits = [];

  List<HabitModel> get habits => _habits;

  // ADD
  void addHabit(HabitModel habit) {
    _habits.add(habit);
    notifyListeners();
  }

  // DELETE
  void deleteHabit(String id) {
    _habits.removeWhere(
      (habit) => habit.id == id,
    );

    notifyListeners();
  }

  // TOGGLE COMPLETE
  void toggleHabit(String id) {
    final index = _habits.indexWhere(
      (habit) => habit.id == id,
    );

    if (index != -1) {
      final oldHabit = _habits[index];

      _habits[index] = HabitModel(
        id: oldHabit.id,
        title: oldHabit.title,
        subtitle: oldHabit.subtitle,
        image: oldHabit.image,
        progress: oldHabit.progress,
        isCompleted:
            !oldHabit.isCompleted,
      );

      notifyListeners();
    }
  }
}