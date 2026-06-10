import 'dart:convert';

class ReflectionRequestModel {
  final String mood;
  final String title;
  final String content;

  ReflectionRequestModel({
    required this.mood,
    required this.title,
    required this.content,
  });

  factory ReflectionRequestModel.fromJson(String str) =>
      ReflectionRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReflectionRequestModel.fromMap(Map<String, dynamic> json) =>
      ReflectionRequestModel(
        mood: json["mood"],
        title: json["title"] ?? 'Daily Reflection',
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toMap() => {
    "mood": mood,
    "title": title.isEmpty ? 'Daily Reflection' : title,
    // 🔥 UBAH BARIS INI: Jika content kosong, beri tulisan default agar lolos dari database Laravel
    "content": content.isEmpty ? 'Saved mood tracking.' : content,
  };
}
