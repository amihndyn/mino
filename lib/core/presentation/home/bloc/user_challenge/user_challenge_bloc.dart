import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mino/core/data/model/request/user_challenge_request_model.dart';
import 'package:mino/core/data/model/response/user_challenge_response_model.dart';
import 'package:mino/core/data/repositories/user_challenge_repository.dart';

part 'user_challenge_event.dart';
part 'user_challenge_state.dart';
part 'user_challenge_bloc.freezed.dart';

class UserChallengeBloc extends Bloc<UserChallengeEvent, UserChallengeState> {
  final UserChallengeRepository _repository;

  UserChallengeBloc(this._repository) : super(const _Initial()) {
    
    // Helper function untuk reload data otomatis setelah aksi selesai
    Future<void> _reloadDataAfterAction(Emitter<UserChallengeState> emit) async {
      final result = await _repository.getUserChallenges();
      result.fold(
        (failureMessage) => emit(_Error(failureMessage)),
        (challengesData) => emit(_Success(challengesData)),
      );
    }

    // 1. HANDLER FETCH DATA
    on<_FetchUserChallenges>((event, emit) async {
      emit(const _Loading());
      final result = await _repository.getUserChallenges();
      result.fold(
        (failureMessage) => emit(_Error(failureMessage)),
        (challengesData) => emit(_Success(challengesData)),
      );
    });

    // 2. HANDLER JOIN CHALLENGE
    on<_JoinChallenge>((event, emit) async {
      emit(const _Loading());
      final requestModel = UserChallengeRequestModel(challengeId: event.challengeId);
      final result = await _repository.joinChallenge(requestModel);
      
      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (success) async {
          await _reloadDataAfterAction(emit);
        },
      );
    });

    // 3. HANDLER CENTANG HARIAN (CHECK IN)
    on<_CheckInChallenge>((event, emit) async {
      final result = await _repository.checkInChallenge(event.id);
      
      await result.fold(
        (failureMessage) async {
          // KUNCI UTAMA: Jika Laravel melempar string 'failed_streak', ubah state ke NeedRevive
          if (failureMessage.contains('failed_streak')) {
            emit(_NeedRevive(event.id, 'Tantanganmu hangus! Tebus dengan 5 Diamond?'));
          } else {
            emit(_Error(failureMessage));
          }
        },
        (updatedChallenge) async {
          await _reloadDataAfterAction(emit);
        },
      );
    });

    // 4. HANDLER TEBUS DIAMOND (REVIVE)
    on<_ReviveChallenge>((event, emit) async {
      emit(const _Loading());
      final result = await _repository.reviveChallenge(event.id);
      
      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (updatedChallenge) async {
          await _reloadDataAfterAction(emit);
        },
      );
    });
  }
}