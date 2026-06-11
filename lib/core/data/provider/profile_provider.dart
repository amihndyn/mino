import 'package:flutter/material.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/core/data/model/response/profile_response_model.dart';
import 'package:mino/core/data/repositories/profile_repository.dart';
// sesuaikan path nya

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository;

  ProfileProvider(this.repository);

  // States
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ProfileResponseModel? _profileData;
  ProfileResponseModel? get profileData => _profileData;

  /// 1. Fungsi untuk memuat data profil saat halaman dibuka
  Future<void> fetchProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.getProfile();
    
    result.fold(
      (failure) {
        _isLoading = false;
        _errorMessage = failure;
        notifyListeners();
      },
      (success) {
        _isLoading = false;
        _profileData = success; // Data disimpan ke state lokal provider
        notifyListeners(); // UI otomatis nge-refresh/nyambung
      },
    );
  }

  /// 2. Fungsi untuk mengupdate profil
  Future<bool> updateProfile(ProfileRequestModel request, String? imagePath) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.updateProfile(request, imagePath);
    
    return result.fold(
      (failure) {
        _isLoading = false;
        _errorMessage = failure;
        notifyListeners();
        return false; // Gagal update
      },
      (success) async {
        _isLoading = false;
        _profileData = success; // PENTING: Timpa data lama dengan data baru dari server
        
        // OPSIONAL: Jika kamu menyimpan data user di AuthLocalDatasource, 
        // kamu bisa meng-update data SharedPreferences-mu di sini agar sinkron.
        // contoh: await AuthLocalDatasource().updateUserLocal(success.user);

        notifyListeners(); // PENTING: Memicu UI Flutter untuk rebuild/berubah secara real-time
        return true; // Sukses update
      },
    );
  }
}