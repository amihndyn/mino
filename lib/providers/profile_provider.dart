import 'package:flutter/material.dart';

import '../models/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _profile;

  ProfileModel? get profile => _profile;

  // SET PROFILE
  void setProfile(
    ProfileModel profile,
  ) {
    _profile = profile;
    notifyListeners();
  }

  // UPDATE NAME
  void updateName(String newName) {
    if (_profile == null) return;

    _profile = ProfileModel(
      name: newName,
      email: _profile!.email,
      avatar: _profile!.avatar,
      streak: _profile!.streak,
      totalHabits:
          _profile!.totalHabits,
    );

    notifyListeners();
  }

  // UPDATE AVATAR
  void updateAvatar(String avatar) {
    if (_profile == null) return;

    _profile = ProfileModel(
      name: _profile!.name,
      email: _profile!.email,
      avatar: avatar,
      streak: _profile!.streak,
      totalHabits:
          _profile!.totalHabits,
    );

    notifyListeners();
  }
}