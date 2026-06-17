part of 'user_challenge_bloc.dart';

@freezed
class UserChallengeEvent with _$UserChallengeEvent {
  const factory UserChallengeEvent.started() = _Started;
  const factory UserChallengeEvent.fetchUserChallenges() = _FetchUserChallenges;
  const factory UserChallengeEvent.joinChallenge(int challengeId) = _JoinChallenge;
  const factory UserChallengeEvent.checkInChallenge(int id) = _CheckInChallenge;
  const factory UserChallengeEvent.reviveChallenge(int id) = _ReviveChallenge;
  const factory UserChallengeEvent.deleteChallenge(int id) = _DeleteChallenge;
}