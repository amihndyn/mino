import '../../models/mood_model.dart';

class MoodApi {
  Future<List<MoodModel>> getMoods()
  async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return [
      MoodModel(
        id: '1',
        mood: 'Happy',
        emoji: '😊',
        note:
            'Today was a productive day.',
        date: '12 May 2026',
      ),

      MoodModel(
        id: '2',
        mood: 'Calm',
        emoji: '😌',
        note:
            'Feeling relaxed tonight.',
        date: '13 May 2026',
      ),
    ];
  }
}