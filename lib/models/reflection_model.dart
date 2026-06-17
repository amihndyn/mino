class ReflectionModel {
  final int id;
  final int userId;
  final String date;
  final String title;
  final String content;
  final String mood;

  ReflectionModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.title,
    required this.content,
    required this.mood,
  });

  factory ReflectionModel.fromJson(Map<String, dynamic> json) {
    return ReflectionModel(
      id: json['id'] is String
          ? int.parse(json['id'])
          : (json['id'] ?? 0),

      userId: json['user_id'] is String
          ? int.parse(json['user_id'])
          : (json['user_id'] ?? 0),

      date: json['date'] ?? '',
      title: json['title'] ?? 'Daily Reflection',
      content: json['content'] ?? '',
      mood: json['mood'] ?? 'good',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date,
      'title': title,
      'content': content,
      'mood': mood,
    };
  }
}