class HabitModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final double progress;
  final bool isCompleted;

  HabitModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.progress,
    required this.isCompleted,
  });

  factory HabitModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HabitModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      progress:
          (json['progress'] ?? 0).toDouble(),
      isCompleted:
          json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'progress': progress,
      'isCompleted': isCompleted,
    };
  }
}