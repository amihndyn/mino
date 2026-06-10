import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/data/model/request/reflection_request_model.dart';
// 🔥 1. Ubah import model lama ke file response model baru kamu
import 'package:mino/core/data/model/response/reflection_response_model.dart'; 

class ReflectionRemoteDatasource {
  
  /// 1. GET /api/reflections — Mengambil semua histori jurnal milik user
  Future<List<Reflection>> getReflections() async { // 💡 Menggunakan 'Reflection'
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/reflections'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body) as List;
        // 💡 Menggunakan Reflection.fromMap(e) karena data berbentuk Map
        return data.map((e) => Reflection.fromMap(e)).toList();
      } else {
        throw Exception('Gagal mengambil histori jurnal');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// 2. GET /api/reflections/today — Mengecek atau mengambil jurnal hari ini
  Future<Reflection?> getTodayReflection() async { // 💡 Menggunakan 'Reflection?'
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/reflections/today'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // 💡 Menggunakan Reflection.fromMap
        return Reflection.fromMap(data);
      } else if (response.statusCode == 404) {
        return null; 
      } else {
        throw Exception('Gagal mengambil data jurnal hari ini');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// 3. POST /api/reflections — Menyimpan baru atau mengupdate jurnal hari ini
  Future<Reflection> saveReflection(ReflectionRequestModel requestModel) async { // 💡 Menggunakan 'Reflection'
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/reflections'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: requestModel.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 💡 Menggunakan ReflectionResponseModel untuk mem-parsing response { "message": "...", "reflection": {...} }
        final responseModel = ReflectionResponseModel.fromJson(response.body);
        return responseModel.reflection!;
      } else {
        throw Exception('Gagal menyimpan data jurnal');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}