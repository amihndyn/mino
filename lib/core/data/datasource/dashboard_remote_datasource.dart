import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';

class DashboardRemoteDatasource {
// 🔥 SEKARANG MENERIMA PARAMETER {int? month}
  Future<Either<String, DashboardResponseModel>> getDashboard({int? month}) async {
    try {
      // 1. Ambil token login dari Local Storage
      final authData = await AuthLocalDatasource().getAuthData();

      // 2. Susun URL beserta Query Parameter secara dinamis untuk http package
      final Map<String, String> queryParameters = {
        if (month != null) 'month': month.toString(), // 🔥 Kirim id bulan ke Laravel jika tidak null
      };

      // Menggabungkan baseUrl + path + query parameters
      final uri = Uri.parse('${Variable.baseUrl}/api/dashboard').replace(
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      // 3. Tembak API Laravel
      final response = await http.get(
        uri, // 🔥 Menggunakan uri yang sudah disisipi query parameter
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      // 4. Cek Status Code
      if (response.statusCode == 200) {
        return Right(DashboardResponseModel.fromJson(response.body));
      } else {
        return Left('Server Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('🔥 ERROR FETCH DASHBOARD: $e');
      return Left(e.toString());
    }
  }

  // 🔥 PERBAIKAN TOGGLE HABIT
  Future<bool> toggleHabitStatus(int userHabitId) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/user-habits/check/$userHabitId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Gagal mengubah status habit: $e');
    }
  }

  // 🔥 PERBAIKAN DELETE HABIT
  Future<bool> deleteHabit(int userHabitId) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      final response = await http.delete(
        Uri.parse('${Variable.baseUrl}/api/user-habits/$userHabitId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Gagal menghapus habit: $e');
    }
  }

  Future<bool> addHabit(String name) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/user-habits'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: jsonEncode({
          'name': name, // Cukup kirim string nama saja!
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Gagal menambahkan habit baru: $e');
    }
  }

  // 🔥 TAMBAHAN UNTUK EDIT HABIT
  Future<bool> editHabit(int userHabitId, String newName) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();

      final response = await http.put(
        Uri.parse('${Variable.baseUrl}/api/user-habits/$userHabitId'), // Pastikan endpoint di Laravel menggunakan PUT
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: jsonEncode({
          'name': newName,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Gagal mengubah habit: $e');
    }
  }
}
