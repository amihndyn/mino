
import 'package:mino/models/habit_model.dart';

class HabitApi {
  Future<List<HabitModel>> getHabits()
  async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return [

    ];
  }
}