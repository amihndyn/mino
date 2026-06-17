import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mino/core/constants/variable.dart';
import 'package:mino/core/data/datasource/auth_local_datasource.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/core/data/model/response/profile_response_model.dart';
import 'package:http_parser/http_parser.dart';

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
  
  /// Update profile data beserta upload foto menggunakan Multipart (VERSI TERBAIK)
  Future<ProfileResponseModel> updateProfile(
    ProfileRequestModel requestModel, 
    String? imagePath, // Path lokal file gambar fisik temporer dari cache HP
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      
      final url = Uri.parse('${Variable.baseUrl}/api/profile/update');
      final request = http.MultipartRequest('POST', url);

      // 1. Tambahkan Headers wajib
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.token}',
      });

      // 2. Ambil data teks dari request model map
      final fieldsMap = requestModel.toMap();

      // 🔥 KUNCI UTAMA: Hapus key 'avatar' dari fields teks biasa.
      // Kita tidak boleh mengirim 'avatar' sebagai string jika backend mewajibkan file gambar asli.
      fieldsMap.remove('avatar'); 

      // Tambahkan sisa data teks (name, email, gender, ttl) ke fields request
      request.fields.addAll(fieldsMap);

      // 3. Tambahkan File Gambar Fisik Asli ke dalam Multipart Request jika ada
      if (imagePath != null && imagePath.isNotEmpty) {
        // Ambil ekstensi file (png atau jpg)
        String extension = imagePath.split('.').last.toLowerCase();
        if (extension == 'jpg') extension = 'jpeg'; // Standarisasi mimetypes jpeg

        request.files.add(
          await http.MultipartFile.fromPath(
            'avatar', // 👈 Pastikan key ini sudah sama dengan backend
            imagePath,
            contentType: MediaType('image', extension), // 🔥 Menegaskan ke backend bahwa ini berkas gambar sah!
          ),
        );
      }

      // Debugging untuk memantau data sebelum meluncur ke server
      print("SENDING FIELDS = ${request.fields}");
      print("SENDING FILES  = ${request.files.map((f) => f.field).toList()}");

      // 4. Kirim request stream ke server
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("STATUS CODE = ${response.statusCode}");
      print("RESPONSE BODY = ${response.body}");

      // 5. Handling Response dari Server
      if (response.statusCode == 200) {
        return ProfileResponseModel.fromJson(response.body);
      } else {
        // Mengantisipasi jika backend menolak dan mengembalikan JSON error (misal validasi gagal)
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal mengupdate profil');
      }
    } catch (e) {
      // 💡 PROTEKSI TAMBAHAN: Jika backend crash total dan melempar teks HTML (<script> Sfdump),
      // jsonDecode akan gagal dan lari ke baris ini. Kita jinakkan agar Flutter tidak ikut crash.
      if (e.toString().contains('FormatException')) {
        throw Exception('Server error (500). Format data ditolak atau ada kesalahan di validasi backend!');
      }
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}