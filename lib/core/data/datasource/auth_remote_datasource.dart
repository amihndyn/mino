import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/data/model/request/login_request_model.dart';
import 'package:mino/core/data/model/request/register_request_model.dart';
import 'package:mino/core/data/model/response/auth_response_model.dart';
import 'package:mino/core/data/model/response/register_response_model.dart';


class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel dataLogin,
  ) async {
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: dataLogin.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

Future<Either<String, String>> logout() async {
    try {
      final authLocalDatasource = AuthLocalDatasource(); // Inisialisasi local datasource
      final authData = await authLocalDatasource.getAuthData();
      
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        // ── 🛠️ WAJIB: Hapus session/token di lokal HP jika API sukses ──
        await authLocalDatasource.removeAuthData();
        return const Right('logout berhasil');
      } else {
        // Opsional: Jika token di backend ternyata sudah expired, 
        // sebaiknya lokal data tetap dihapus agar user tidak stuck.
        await authLocalDatasource.removeAuthData(); 
        return Left(response.body);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, RegisterResponseModel>> register(
    RegisterRequestModel dataRegister,
  ) async {
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: dataRegister.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(RegisterResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
