import 'dart:convert';

class UserChallengeResponseModel {
  final String status;
  final List<UserChallenge> data;

  UserChallengeResponseModel({
    required this.status,
    required this.data,
  });

  factory UserChallengeResponseModel.fromJson(String str) =>
      UserChallengeResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserChallengeResponseModel.fromMap(Map<String, dynamic> json) =>
      UserChallengeResponseModel(
        status: json["status"] ?? '',
        data: json["data"] == null
            ? []
            : List<UserChallenge>.from(
                json["data"].map((x) => UserChallenge.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class UserChallenge {
  final int id;
  final int challengeId;
  final String name;
  final String description;
  final int progressDays;
  final int requiredDays;
  final String status;
  final String? lastProgressDate;
  final bool isCheckedToday;

  UserChallenge({
    required this.id,
    required this.challengeId,
    required this.name,
    required this.description,
    required this.progressDays,
    required this.requiredDays,
    required this.status,
    this.lastProgressDate,
    required this.isCheckedToday,
  });

  factory UserChallenge.fromJson(String str) =>
      UserChallenge.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserChallenge.fromMap(Map<String, dynamic> json) => UserChallenge(
        id: json["id"] ?? 0,
        challengeId: json["challenge_id"] ?? 0,
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        progressDays: json["progress_days"] ?? 0,
        requiredDays: json["required_days"] ?? 0,
        status: json["status"] ?? 'active',
        lastProgressDate: json["last_progress_date"],
        isCheckedToday: json["is_checked_today"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "challenge_id": challengeId,
        "name": name,
        "description": description,
        "progress_days": progressDays,
        "required_days": requiredDays,
        "status": status,
        "last_progress_date": lastProgressDate,
        "is_checked_today": isCheckedToday,
      };

  // copyWith untuk memudahkan State Management BLoC melakukan update UI nantinya
  UserChallenge copyWith({
    int? id,
    int? challengeId,
    String? name,
    String? description,
    int? progressDays,
    int? requiredDays,
    String? status,
    String? lastProgressDate,
    bool? isCheckedToday,
  }) {
    return UserChallenge(
      id: id ?? this.id,
      challengeId: challengeId ?? this.challengeId,
      name: name ?? this.name,
      description: description ?? this.description,
      progressDays: progressDays ?? this.progressDays,
      requiredDays: requiredDays ?? this.requiredDays,
      status: status ?? this.status,
      lastProgressDate: lastProgressDate ?? this.lastProgressDate,
      isCheckedToday: isCheckedToday ?? this.isCheckedToday,
    );
  }
}