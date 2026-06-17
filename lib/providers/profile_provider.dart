import 'package:flutter/material.dart';
import 'package:mino/core/data/repositories/profile_repository.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/models/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _repository;

  ProfileModel? _profile;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ProfileProvider(this._repository);

  Future<void> fetchProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _repository.getProfile();

    result.fold(
      (error) {
        _errorMessage = error;
      },
      (response) {
        _profile = response.user;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(
  ProfileRequestModel request,
  String? imagePath,
) async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  // ── LOG DEBUGGING (CEK DATA SEBELUM DIKIRIM) ──
  print("DATA YANG AKAN DIKIRIM KE REPO:");
  print("Name: ${request.name}");
  print("Email: ${request.email}");
  print("Gender: ${request.gender}");
  print("TTL: ${request.ttl}");
  print("Avatar Path dikirim ke Repo: $imagePath");

  final result = await _repository.updateProfile(
    request,
    imagePath,
  );

  bool isSuccess = false;

  result.fold(
    (error) {
      // 🔥 RE-FORMAT ERROR AGAR TIDAK MUNCUL HTML <script> DI LAYAR WINDOWS/HP
      if (error.contains('<script') || error.contains('<!DOCTYPE')) {
        _errorMessage = "Server error (500). Backend kamu crash/format salah!";
      } else {
        _errorMessage = error;
      }
      isSuccess = false;
    },
    (response) {
      _profile = response.user;
      isSuccess = true;
    },
  );

  _isLoading = false;
  notifyListeners();

  return isSuccess;
}
}