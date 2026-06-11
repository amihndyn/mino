import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/core/data/model/response/profile_response_model.dart';
import 'package:mino/core/data/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(const _Initial()) {
    
    // HANDLER: UPDATE PROFILE (Data & Upload Foto)
    on<_UpdateProfile>((event, emit) async {
      emit(const _Loading());
      
      final result = await _repository.updateProfile(
        event.request, 
        event.imagePath,
      );
      
      result.fold(
        (failure) => emit(_Error(failure)),
        (profileResponse) => emit(_Success(profileResponse)),
      );
    });

  }
}