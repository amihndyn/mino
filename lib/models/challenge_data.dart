class ChallengeData {
  final String id;
  final String title;
  final String description;
  final String imageAsset;
  final int diamondReward;
  final int durationDays;
  final String dateInfo;
  final bool isCompleted; 
  bool isFavorite; // 🔥 Tambahkan variabel ini

  ChallengeData({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.diamondReward,
    required this.durationDays,
    required this.dateInfo,
    this.isCompleted = false,
    this.isFavorite = false, // 🔥 Default bernilai false
  });
}