class ChallengeModel {
  final String id;
  final String title;
  final String subtitle;
  final double progress;
  final bool isCompleted;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.isCompleted,
  });

  factory ChallengeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChallengeModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
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
      'progress': progress,
      'isCompleted': isCompleted,
    };
  }
}