import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/core/data/model/response/profile_response_model.dart';

class ProfileRemoteDatasource {

  /// Mengambil data profile terbaru dari server
  Future<ProfileResponseModel> getProfile() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        return ProfileResponseModel.fromJson(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal mengambil profil');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
  
  /// Update profile data beserta upload foto menggunakan Multipart
  Future<ProfileResponseModel> updateProfile(
    ProfileRequestModel requestModel, 
    String? imagePath, // Path lokal file gambar (misal hasil dari image_picker)
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      
      // 1. Inisialisasi MultipartRequest karena ada upload file
      final url = Uri.parse('${Variable.baseUrl}/api/profile/update');
      final request = http.MultipartRequest('POST', url);

      // 2. Tambahkan Headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      });

      // 3. Tambahkan Data Teks dari Request Model
      request.fields.addAll(requestModel.toMap());

      // 4. Tambahkan File Foto jika user memilih foto baru
      if (imagePath != null && imagePath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('photo', imagePath),
        );
      }

      // 5. Kirim Request ke Laravel
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // 6. Handling Response
      if (response.statusCode == 200) {
        return ProfileResponseModel.fromJson(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal mengupdate profil');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}