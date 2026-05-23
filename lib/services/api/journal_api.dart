import '../../models/journal_model.dart';

class JournalApi {
  Future<List<JournalModel>>
      getJournals() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return [
      JournalModel(
        id: '1',
        title: 'Today Story',
        content:
            'Today I learned Flutter UI structure.',
        date: '12 May 2026',
      ),

      JournalModel(
        id: '2',
        title: 'Mood Notes',
        content:
            'Feeling productive and calm.',
        date: '13 May 2026',
      ),
    ];
  }
}