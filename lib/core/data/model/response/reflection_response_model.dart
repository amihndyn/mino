import 'dart:convert';

class ReflectionResponseModel {
  final String? message;
  final Reflection? reflection;

  ReflectionResponseModel({
    this.message,
    this.reflection,
  });

  factory ReflectionResponseModel.fromJson(String str) =>
      ReflectionResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReflectionResponseModel.fromMap(Map<String, dynamic> json) =>
      ReflectionResponseModel(
        message: json["message"],
        reflection: json["reflection"] == null
            ? null
            : Reflection.fromMap(json["reflection"]),
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "reflection": reflection?.toMap(),
  };
}

class Reflection {
  final int? id;
  final int? userId;
  final int? userHabitId;
  final String? date;
  final String? title;
  final String? content;
  final String? mood;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Reflection({
    this.id,
    this.userId,
    this.userHabitId,
    this.date,
    this.title,
    this.content,
    this.mood,
    this.createdAt,
    this.updatedAt,
  });

  factory Reflection.fromJson(String str) => Reflection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reflection.fromMap(Map<String, dynamic> json) => Reflection(
    id: json["id"] is String
        ? int.parse(json["id"])
        : json["id"],

    userId: json["user_id"] is String
        ? int.parse(json["user_id"])
        : json["user_id"],

    userHabitId: json["user_habit_id"] == null
        ? null
        : (json["user_habit_id"] is String
            ? int.parse(json["user_habit_id"])
            : json["user_habit_id"]),

    date: json["date"],
    title: json["title"],
    content: json["content"],
    mood: json["mood"],

    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),

    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "user_habit_id": userHabitId,
    "date": date,
    "title": title,
    "content": content,
    "mood": mood,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  // 💡 Ini sangat berguna nanti jika kamu menerapkan SQLite
  factory Reflection.fromLocalMap(Map<String, dynamic> json) => Reflection(
    id: json["id"],
    userId: json["user_id"],
    userHabitId: json["user_habit_id"],
    date: json["date"],
    title: json["title"],
    content: json["content"],
    mood: json["mood"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toLocalMap() => {
    "id": id,
    "user_id": userId,
    "user_habit_id": userHabitId,
    "date": date,
    "title": title,
    "content": content,
    "mood": mood,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Reflection &&
      other.id == id &&
      other.userId == userId &&
      other.userHabitId == userHabitId &&
      other.date == date &&
      other.title == title &&
      other.content == content &&
      other.mood == mood &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      userHabitId.hashCode ^
      date.hashCode ^
      title.hashCode ^
      content.hashCode ^
      mood.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }

  Reflection copyWith({
    int? id,
    int? userId,
    int? userHabitId,
    String? date,
    String? title,
    String? content,
    String? mood,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Reflection(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userHabitId: userHabitId ?? this.userHabitId,
      date: date ?? this.date,
      title: title ?? this.title,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}