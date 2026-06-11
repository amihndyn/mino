import 'dart:convert';

class ProfileResponseModel {
  final String? message;
  final UserProfile? user;

  ProfileResponseModel({
    this.message,
    this.user,
  });

  factory ProfileResponseModel.fromJson(String str) =>
      ProfileResponseModel.fromMap(json.decode(str));

  factory ProfileResponseModel.fromMap(Map<String, dynamic> json) => ProfileResponseModel(
        message: json["message"],
        user: json["user"] == null ? null : UserProfile.fromMap(json["user"]),
      );
}

class UserProfile {
  final int? id;
  final String? name;
  final String? email;
  final String? gender;
  final String? ttl;
  final String? photoUrl;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.ttl,
    this.photoUrl,
  });

  factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        ttl: json["ttl"],
        photoUrl: json["photo_url"],
      );
}