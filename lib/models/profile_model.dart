class ProfileModel {
  final String name;
  final String email;
  final String avatar; 
  final int streak;
  final int totalHabits;
  final int focusHours;    
  final int diamondEarned; 
  final String? gender;
  final String? ttl;

  ProfileModel({
    required this.name,
    required this.email,
    required this.avatar,
    required this.streak,
    required this.totalHabits,
    this.focusHours = 0,
    this.diamondEarned = 0,
    this.gender, 
    this.ttl,
  });

 factory ProfileModel.fromJson(Map<String, dynamic> json) {
  final stats = json['stats'] ?? json['statistics'] ?? json;

  return ProfileModel(
    name: json['name'] ?? '',
    email: json['email'] ?? '',

    avatar: json['photo_url'] ??
        json['avatar'] ??
        'assets/images/default.png',

    streak: stats['streak'] ?? stats['total_streak'] ?? 0,
    totalHabits: stats['totalHabits'] ??
        stats['total_habits'] ??
        stats['habits_completed'] ??
        stats['habitsCount'] ??
        0,

    focusHours: stats['focusHours'] ??
        stats['focus_hours'] ??
        stats['total_focus_hours'] ??
        0,

    diamondEarned: stats['diamondEarned'] ??
        stats['diamond_earned'] ??
        stats['diamonds'] ??
        0,

    gender: json['gender'],
    ttl: json['ttl'],
  );
}
}