import 'dart:convert';

class RegisterResponseModel {
  final String? message;
  final RegisteredUser? user;

  RegisterResponseModel({this.message, this.user});

  factory RegisterResponseModel.fromJson(String str) =>
      RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        message: json["message"],
        user: json["user"] != null
            ? RegisteredUser.fromMap(json["user"])
            : null,
      );

  Map<String, dynamic> toMap() => {"message": message, "user": user?.toMap()};
}

class RegisteredUser {
  final int? id;
  final String? name;
  final String? email;
  final String? createdAt;
  final String? updatedAt;

  RegisteredUser({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory RegisteredUser.fromJson(String str) =>
      RegisteredUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisteredUser.fromMap(Map<String, dynamic> json) => RegisteredUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
