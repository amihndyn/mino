class ChallengeData {
  final String id;
  final String title;
  final String imageAsset;
  final String detailImageAsset;
  final String description;
  final int diamondReward;
  final int durationDays;
  final String dateInfo;

  final bool isCompleted;

  ChallengeData({
    required this.id,
    required this.title,
    required this.imageAsset,
    required this.detailImageAsset,
    required this.description,
    required this.diamondReward,
    required this.durationDays,
    required this.dateInfo,
    this.isCompleted = false,
  });
}