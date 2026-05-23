import 'package:flutter/material.dart';

import '../models/challenge_model.dart';

class ChallengeProvider extends ChangeNotifier {
  final List<ChallengeModel> _challenges =
      [];

  List<ChallengeModel> get challenges =>
      _challenges;

  // ADD
  void addChallenge(
    ChallengeModel challenge,
  ) {
    _challenges.add(challenge);
    notifyListeners();
  }

  // DELETE
  void deleteChallenge(String id) {
    _challenges.removeWhere(
      (challenge) =>
          challenge.id == id,
    );

    notifyListeners();
  }

  // TOGGLE COMPLETE
  void toggleChallenge(String id) {
    final index = _challenges.indexWhere(
      (challenge) =>
          challenge.id == id,
    );

    if (index != -1) {
      final oldChallenge =
          _challenges[index];

      _challenges[index] =
          ChallengeModel(
        id: oldChallenge.id,
        title: oldChallenge.title,
        subtitle: oldChallenge.subtitle,
        progress: oldChallenge.progress,
        isCompleted:
            !oldChallenge.isCompleted,
      );

      notifyListeners();
    }
  }
}