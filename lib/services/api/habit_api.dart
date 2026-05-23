import '../../models/habit_model.dart';

class HabitApi {
  Future<List<HabitModel>> getHabits()
  async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return [
      HabitModel(
        id: '1',
        title: 'Morning Run',
        subtitle: 'Run 5km every morning',
        image:
            'assets/images/run.png',
        progress: 0.7,
        isCompleted: false,
      ),

      HabitModel(
        id: '2',
        title: 'Drink Water',
        subtitle: '8 glasses everyday',
        image:
            'assets/images/water.png',
        progress: 0.4,
        isCompleted: false,
      ),
    ];
  }
}