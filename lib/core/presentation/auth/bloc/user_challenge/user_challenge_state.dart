part of 'user_challenge_bloc.dart';

@freezed
class UserChallengeState with _$UserChallengeState {
  const factory UserChallengeState.initial() = _Initial;
  const factory UserChallengeState.loading() = _Loading;
  const factory UserChallengeState.success(List<UserChallenge> challenges) = _Success;
  const factory UserChallengeState.needRevive(int userChallengeId, String message) = _NeedRevive;
  const factory UserChallengeState.error(String message) = _Error;
}