import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/data/model/request/user_challenge_request_model.dart';
import 'package:mino/core/data/model/response/user_challenge_response_model.dart';

class UserChallengeRemoteDatasource {
  
  // Helper internal untuk mengambil header dengan token otomatis
  Future<Map<String, String>> _getHeaders() async {
    final authData = await AuthLocalDatasource().getAuthData();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData.token}',
    };
  }

  /// 1. GET /api/user-challenges — Mengambil list tantangan aktif milik user
  Future<List<UserChallenge>> getUserChallenges() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/user-challenges'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // Parsing response menggunakan format UserChallengeResponseModel kamu
        final responseModel = UserChallengeResponseModel.fromJson(response.body);
        return responseModel.data;
      } else {
        throw Exception('Gagal mengambil data tantangan');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// 2. POST /api/user-challenges/join — Ikut tantangan baru
  Future<bool> joinChallenge(UserChallengeRequestModel requestModel) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/user-challenges/join'),
        headers: headers,
        body: requestModel.toJson(),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal mengikuti tantangan baru');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// 3. POST /api/user-challenges/check/{id} — Tombol centang harian
  Future<UserChallenge> checkInChallenge(int id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/user-challenges/check/$id'),
        headers: headers,
      );

      final resBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserChallenge.fromMap(resBody['data']);
      } else if (response.statusCode == 400 && resBody['status'] == 'failed_streak') {
        // Lempar pesan custom ini agar dibaca BLoC untuk memicu dialog revive
        throw Exception('failed_streak');
      } else {
        throw Exception(resBody['message'] ?? 'Gagal mencentang tantangan harian');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// 4. POST /api/user-challenges/revive/{id} — Bayar 5 diamond untuk memulihkan tantangan
  Future<UserChallenge> reviveChallenge(int id) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/user-challenges/revive/$id'),
        headers: headers,
      );

      final resBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserChallenge.fromMap(resBody['data']);
      } else {
        throw Exception(resBody['message'] ?? 'Gagal memulihkan tantangan');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}