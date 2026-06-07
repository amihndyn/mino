import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';


class DashboardRemoteDatasource {
  Future<Either<String, DashboardResponseModel>> getDashboard() async {
    try {
      // 1. Ambil token token login si Bahlil dari Local Storage (SharedPreferences)
      // Catatan: Jika kamu belum buat AuthLocalDatasource, sementara bisa hardcode dulu tokennya
      final authData = await AuthLocalDatasource().getAuthData();

      // 2. Tembak API Laravel
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/dashboard'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      // 3. Cek Status Code
      if (response.statusCode == 200) {
        // Jika sukses (200), bungkus model di dalam 'Right'
        return Right(DashboardResponseModel.fromJson(response.body));
      } else {
        // Jika gagal server (400/404/500), bungkus pesan error di dalam 'Left'
        return Left('Server Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Jika gagal koneksi (misal Wi-Fi putus / IP salah)
      return Left('Koneksi Gagal: $e');
    }
  }
}