import 'dart:convert';
// ⚠️ Pastikan path import ini mengarah ke file ProfileModel baru kamu yang ada fromJson-nya!
import 'package:mino/models/profile_model.dart'; 

class ProfileResponseModel {
  final String? message;
  final ProfileModel? user; // Diubah jadi nullable (?) agar aman jika key 'user' absen dari JSON

  ProfileResponseModel({
    this.message,
    this.user,
  });

  factory ProfileResponseModel.fromJson(String str) =>
      ProfileResponseModel.fromMap(json.decode(str));

  factory ProfileResponseModel.fromMap(Map<String, dynamic> json) => ProfileResponseModel(
        message: json["message"],
        // ✨ SEKARANG SINKRON: Menggunakan ProfileModel.fromJson langsung untuk properti 'user'
        user: json["user"] == null ? null : ProfileModel.fromJson(json["user"]),
      );
}