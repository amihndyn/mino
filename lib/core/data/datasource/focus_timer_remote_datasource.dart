import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';

class FocusTimerRemoteDatasource {
  // 1. Fungsi untuk MULAI timer (Mengembalikan ID Timer dari Laravel)
  Future<int> startFocus({
    int? userHabitId,
    int? userChallengeId,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/focus/start'), // Pastikan route ini sesuai di api.php
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: jsonEncode({
          'user_habit_id': userHabitId, // Bisa null kalau fokus bebas, atau isi ID habit
          'user_challenge_id': userChallengeId,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['id']; 
      } else {
        // 🛠️ PERBAIKAN: Cetak error asli dari API agar ketahuan penyebabnya
        print('STATUS CODE: ${response.statusCode}');
        print('RESPONSE BODY: ${response.body}');
        
        // Opsional: Lempar error beserta pesan dari API agar muncul di SnackBar
        throw Exception('API Error ${response.statusCode}: ${response.body}');
      
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // 2. Fungsi untuk SELESAI timer
  Future<bool> completeFocus({required int timerId, required int durationMinutes}) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/focus/complete'), // Pastikan route ini sesuai di api.php
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: jsonEncode({
          'id': timerId,
          'duration_minutes': durationMinutes,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}