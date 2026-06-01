import 'package:flutter/material.dart';
import 'package:mino/core/data/datasource/auth_remote_datasource.dart';
import 'package:mino/core/data/model/request/register_request_model.dart'; // Import Model Anda

class AuthProvider extends ChangeNotifier {
  final AuthRemoteDatasource _authRemoteDatasource;
  
  AuthProvider(this._authRemoteDatasource);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Mengembalikan String pesan error jika gagal (Left), atau null jika sukses (Right)
  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    _isLoading = true;
    notifyListeners(); 

    // 1. Bungkus data mentah ke dalam Object Model sesuai permintaan Datasource
    final requestModel = RegisterRequestModel(
      name: name,
      email: email,
      password: password,
      // Catatan: Jika garis merah di sini, pastikan nama parameter 
      // di dalam file register_request_model.dart Anda sudah cocok.
      // (Bisa jadi bernama 'password_confirmation' atau 'passwordConfirmation')
      passwordConfirmation: passwordConfirmation, 
    );

    try {
      // 2. Panggil API. Hasilnya adalah Either<String, RegisterResponseModel>
      final result = await _authRemoteDatasource.register(requestModel);
      
      _isLoading = false;
      notifyListeners();
      
      // 3. Karena Anda memakai package Dartz, urai hasilnya menggunakan .fold()
      return result.fold(
        (errorMessage) => errorMessage, // JIKA GAGAL (Left): Kembalikan string error
        (successData) => null,          // JIKA SUKSES (Right): Kembalikan null
      );
      
    } catch (e) {
      // Penanganan berlapis jika terjadi error sistem (misal tidak ada koneksi internet)
      _isLoading = false;
      notifyListeners();
      return e.toString().replaceAll('Exception: ', '');
    }
  }
}