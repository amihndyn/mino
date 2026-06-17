class ChallengeData {
  final int id;
  final String title;
  final String imageAsset;
  final String detailImageAsset;
  final String description;
  final int diamondReward;
  final int durationDays;
  final String dateInfo;
  
  // Field dinamis dari tabel pivot user_challenges
  final int currentProgress;
  final String status;

  ChallengeData({
    required this.id,
    required this.title,
    required this.imageAsset,
    required this.detailImageAsset,
    required this.description,
    required this.diamondReward,
    required this.durationDays,
    required this.dateInfo,
    this.currentProgress = 0,
    this.status = 'inactive',
  });

  // 1. Factory untuk data master (ChallengeController)
  factory ChallengeData.fromMap(Map<String, dynamic> map) {
    return ChallengeData(
      id: map['id'] is String ? int.parse(map['id']) : (map['id'] ?? 0),
      title: map['name'] ?? map['title'] ?? '', 
      imageAsset: map['image_asset'] ?? '',
      detailImageAsset: map['detail_image_asset'] ?? '',
      description: map['description'] ?? '',
      diamondReward: map['diamond_reward'] is String ? int.parse(map['diamond_reward']) : (map['diamond_reward'] ?? 50),
      durationDays: map['duration_days'] is String ? int.parse(map['duration_days']) : (map['duration_days'] ?? 7),
      dateInfo: map['date_info'] ?? 'June 2026',
    );
  }

  // 2. Factory untuk data relasi user (UserChallengeResource)
  factory ChallengeData.fromUserChallengeMap(Map<String, dynamic> map) {
    final challenge = map['challenge'] as Map<String, dynamic>? ?? {};

    return ChallengeData(
      id: challenge['id'] is String ? int.parse(challenge['id']) : (challenge['id'] ?? 0),
      title: challenge['name'] ?? challenge['title'] ?? '',
      imageAsset: challenge['image_asset'] ?? '',
      detailImageAsset: challenge['detail_image_asset'] ?? '',
      description: challenge['description'] ?? '',
      diamondReward: challenge['diamond_reward'] is String ? int.parse(challenge['diamond_reward']) : (challenge['diamond_reward'] ?? 50),
      durationDays: challenge['duration_days'] is String ? int.parse(challenge['duration_days']) : (challenge['duration_days'] ?? 7),
      dateInfo: challenge['date_info'] ?? 'June 2026',

      currentProgress: map['progress_days'] is String ? int.parse(map['progress_days']) : (map['progress_days'] ?? 0),
      status: map['status']?.toString() ?? 'active',
    );
  }

  // ── 🌟 TAMBAHKAN KODE INI DI SINI ──────────────────────────────────────────
  // Fungsi copyWith untuk menduplikasi objek dengan beberapa data yang diubah
  ChallengeData copyWith({
    int? id,
    String? title,
    String? imageAsset,
    String? detailImageAsset,
    String? description,
    int? diamondReward,
    int? durationDays,
    String? dateInfo,
    int? currentProgress,
    String? status,
  }) {
    return ChallengeData(
      id: id ?? this.id,
      title: title ?? this.title,
      imageAsset: imageAsset ?? this.imageAsset,
      detailImageAsset: detailImageAsset ?? this.detailImageAsset,
      description: description ?? this.description,
      diamondReward: diamondReward ?? this.diamondReward,
      durationDays: durationDays ?? this.durationDays,
      dateInfo: dateInfo ?? this.dateInfo,
      currentProgress: currentProgress ?? this.currentProgress,
      status: status ?? this.status,
    );
  }
}