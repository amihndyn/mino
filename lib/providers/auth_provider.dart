import 'package:flutter/material.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/data/datasource/auth_remote_datasource.dart';
import 'package:mino/core/data/model/request/login_request_model.dart'; // Wajib import ini
import 'package:mino/core/data/model/request/register_request_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRemoteDatasource _authRemoteDatasource;
  
  AuthProvider(this._authRemoteDatasource);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // ==========================================
  // FUNGSI REGISTER
  // ==========================================
  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    _isLoading = true;
    notifyListeners(); 

    final requestModel = RegisterRequestModel(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation, 
    );

    try {
      final result = await _authRemoteDatasource.register(requestModel);
      
      _isLoading = false;
      notifyListeners();
      
      return result.fold(
        (errorMessage) => errorMessage, 
        (successData) => null, // Sukses = tidak ada pesan error          
      );
      
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  // ==========================================
  // FUNGSI LOGIN
  // ==========================================
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners(); 

    // 1. Bungkus inputan UI ke dalam LoginRequestModel
    final requestModel = LoginRequestModel(
      email: email,
      password: password,
    );

    try {
      // 2. Tembak API lewat datasource
      final result = await _authRemoteDatasource.login(requestModel);
      
      _isLoading = false;
      notifyListeners();
      
      // 3. Urai hasil dari Dartz Either
      return result.fold(
        (errorMessage) => errorMessage, // JIKA GAGAL: Lempar pesan error ke UI
        (successData) {
          // JIKA SUKSES: Simpan token & data user ke memori lokal HP
          // Asumsi kamu punya fungsi saveAuthData di AuthLocalDatasource
          AuthLocalDatasource().saveAuthData(successData); 
          
          return null; // Mengembalikan null tanda bahwa proses sukses tanpa error
        },
      );
      
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString().replaceAll('Exception: ', '');
    }
  }

  // ==========================================
  // FUNGSI LOGOUT (Bonus Tambahan Sesuai Datasource-mu)
  // ==========================================
  Future<String?> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _authRemoteDatasource.logout();
      
      _isLoading = false;
      notifyListeners();

      return result.fold(
        (errorMessage) => errorMessage,
        (successMessage) {
          // Hapus token dari lokal HP jika logout sukses
          AuthLocalDatasource().removeAuthData(); 
          return null;
        },
      );
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString().replaceAll('Exception: ', '');
    }
  }
} 