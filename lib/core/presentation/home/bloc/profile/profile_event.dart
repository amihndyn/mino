part of 'profile_bloc.dart';

@freezed
sealed class ProfileEvent with _$ProfileEvent { 
  const factory ProfileEvent.updateProfile({
    required ProfileRequestModel request,
    String? imagePath,
  }) = _UpdateProfile;
}