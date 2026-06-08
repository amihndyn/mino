import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';

class HabitRemoteDatasource {
  Future<List<String>> getHabitCatalog() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/habits'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        // Kita hanya mengambil string 'name' nya saja agar mudah dikelola UI
        return data.map((e) => e['name'].toString()).toList();
      } else {
        throw Exception('Gagal mengambil katalog habit');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}