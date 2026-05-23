import 'package:flutter/material.dart';

import '../models/journal_model.dart';

class JournalProvider extends ChangeNotifier {
  final List<JournalModel> _journals = [];

  List<JournalModel> get journals =>
      _journals;

  // ADD
  void addJournal(JournalModel journal) {
    _journals.add(journal);
    notifyListeners();
  }

  // DELETE
  void deleteJournal(String id) {
    _journals.removeWhere(
      (journal) => journal.id == id,
    );

    notifyListeners();
  }

  // UPDATE
  void updateJournal(
    String id,
    JournalModel updatedJournal,
  ) {
    final index = _journals.indexWhere(
      (journal) => journal.id == id,
    );

    if (index != -1) {
      _journals[index] = updatedJournal;
      notifyListeners();
    }
  }
}