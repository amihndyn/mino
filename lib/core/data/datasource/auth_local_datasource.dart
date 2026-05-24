//buat handle sesuatu yg disimpan di penyimapann lokal hp
//kayak token, data user atau lainya, disini penyimpanan lokal pke sahe preferences, tp bisa juga pke yg lain sepertii hive, sqflite, dll
//shared preferences => penyimpanan lokal di hp atau penyimpanan data kecil
//(token, sesi login)
//sifatny presisten (data tetap ada walaupun aplikasi di tutupi)


import 'package:mino/core/data/model/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', data.toJson());
  }

  //remove data login
  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
  }

  //ambil data yg login
  Future<AuthResponseModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    if (data != null) {
      return AuthResponseModel.fromJson(data);
    } else {
      throw Exception('data auth tdk ditemukan');
    }
  }

  //cek apakh user ud login atau belum, pk bool karna cmn ada 2 kemungkinan
  Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('auth_data');
  }
}
