class MoodModel {
  final String id;
  final String mood;
  final String emoji;
  final String note;
  final String date;

  MoodModel({
    required this.id,
    required this.mood,
    required this.emoji,
    required this.note,
    required this.date,
  });

  factory MoodModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MoodModel(
      id: json['id'],
      mood: json['mood'],
      emoji: json['emoji'],
      note: json['note'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mood': mood,
      'emoji': emoji,
      'note': note,
      'date': date,
    };
  }
}