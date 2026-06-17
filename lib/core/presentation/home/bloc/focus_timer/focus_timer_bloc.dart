import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mino/core/data/repositories/focus_timer_repository.dart'; // Sesuaikan path-nya

part 'focus_timer_event.dart';
part 'focus_timer_state.dart';
part 'focus_timer_bloc.freezed.dart';

class FocusTimerBloc extends Bloc<FocusTimerEvent, FocusTimerState> {
  final FocusTimerRepository _repository;

  FocusTimerBloc(this._repository) : super(const _Initial()) {
    
    // HANDLER 1: START FOCUS
    on<_StartFocus>((event, emit) async {
      emit(const _Loading());

      final result = await _repository.startFocus(
        userHabitId: event.userHabitId,
        userChallengeId: event.userChallengeId,
      );

      result.fold(
        (failure) => emit(_Error(failure)),
        (timerId) => emit(_Started(timerId)),
      );
    });

    // HANDLER 2: COMPLETE FOCUS
    on<_CompleteFocus>((event, emit) async {
      emit(const _Loading());
      final result = await _repository.completeFocus(
        timerId: event.timerId, 
        durationMinutes: event.durationMinutes,
      );
      
      result.fold(
        (failure) => emit(_Error(failure)),
        (success) => emit(const _Completed()),
      );
    });
    
  }
}