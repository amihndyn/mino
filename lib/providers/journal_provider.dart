import 'package:flutter/material.dart';
import 'package:mino/models/journal_entry_model.dart.dart';
import 'package:mino/services/api/journal_api.dart';

class JournalProvider extends ChangeNotifier {
  final JournalApi _journalApi = JournalApi();
  List<JournalEntry> _journals = [];
  bool _isLoading = false;

  List<JournalEntry> get journals => _journals;
  bool get isLoading => _isLoading;

  // FETCH DATA DARI API MOCK
  Future<void> fetchJournals() async {
    _isLoading = true;
    notifyListeners();

    try {
      _journals = await _journalApi.getJournals();
    } catch (e) {
      debugPrint("Error fetching journals: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ADD
  void addJournal(JournalEntry journal) {
    _journals.insert(0, journal); // Masukkan di paling atas list (terbaru)
    notifyListeners();
  }

  // DELETE
  void deleteJournal(String id) {
    _journals.removeWhere((journal) => journal.id == id);
    notifyListeners();
  }

  // UPDATE
  void updateJournal(String id, JournalEntry updatedJournal) {
    final index = _journals.indexWhere((journal) => journal.id == id);
    if (index != -1) {
      _journals[index] = updatedJournal;
      notifyListeners();
    }
  }
}