import 'package:flutter/material.dart';
import '../models/challenge_data.dart';


class ChallengeProvider extends ChangeNotifier {
  final List<ChallengeData> _challenges = [];

  List<ChallengeData> get challenges => _challenges;

  // ADD
  void addChallenge(ChallengeData challenge) {
    _challenges.add(challenge);
    notifyListeners();
  }

  // DELETE
  void deleteChallenge(String id) {
    _challenges.removeWhere((challenge) => challenge.id == id);
    notifyListeners();
  }

  // TOGGLE COMPLETE
  void toggleChallenge(String id) {
    final index = _challenges.indexWhere((challenge) => challenge.id == id);

    if (index != -1) {
      final oldChallenge = _challenges[index];

      // 🔥 Diperbaiki: Menggunakan properti dari ChallengeData yang sebenarnya
      _challenges[index] = ChallengeData(
        id: oldChallenge.id,
        title: oldChallenge.title,
        description: oldChallenge.description,
        imageAsset: oldChallenge.imageAsset,
        diamondReward: oldChallenge.diamondReward,
        durationDays: oldChallenge.durationDays,
        dateInfo: oldChallenge.dateInfo,
        isCompleted: !oldChallenge.isCompleted, // Membalikkan status boolean
      );

      notifyListeners();
    }
  }
}