class ProfileModel {
  final String name;
  final String email;
  final String avatar;
  final int streak;
  final int totalHabits;

  ProfileModel({
    required this.name,
    required this.email,
    required this.avatar,
    required this.streak,
    required this.totalHabits,
  });

  factory ProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      streak: json['streak'] ?? 0,
      totalHabits:
          json['totalHabits'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
      'streak': streak,
      'totalHabits': totalHabits,
    };
  }
}