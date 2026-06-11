import 'dart:convert';

class UserChallengeRequestModel {
  final int challengeId;

  UserChallengeRequestModel({
    required this.challengeId,
  });

  factory UserChallengeRequestModel.fromJson(String str) =>
      UserChallengeRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserChallengeRequestModel.fromMap(Map<String, dynamic> json) =>
      UserChallengeRequestModel(
        challengeId: json["challenge_id"],
      );

  Map<String, dynamic> toMap() => {
        "challenge_id": challengeId,
      };
}