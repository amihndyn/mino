import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mino/core/data/model/response/user_challenge_response_model.dart';

class UserChallengeLocalDatasource {
  static const String _cachedKey = 'cached_user_challenges';

  // 1. Simpan data dari internet ke lokal HP
  Future<void> cacheUserChallenges(List<UserChallenge> challenges) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> mappedData = challenges.map((e) => e.toMap()).toList();
    await prefs.setString(_cachedKey, jsonEncode(mappedData));
  }

  // 2. Ambil data lokal saat HP sedang offline
  Future<List<UserChallenge>> getCachedUserChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedString = prefs.getString(_cachedKey);
    
    if (cachedString != null) {
      final List decodedData = jsonDecode(cachedString) as List;
      return decodedData.map((e) => UserChallenge.fromMap(e)).toList();
    }
    
    return []; // Kembalikan list kosong jika belum ada cache sama sekali
  }

  // 3. Hapus cache jika user logout
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cachedKey);
  }
}