part of 'focus_timer_bloc.dart';

@freezed
class FocusTimerState with _$FocusTimerState {
  const factory FocusTimerState.initial() = _Initial;
  const factory FocusTimerState.loading() = _Loading;

  // State saat start berhasil (menyimpan timerId dari Laravel)
  const factory FocusTimerState.started(int timerId) = _Started;

  // State saat complete berhasil
  const factory FocusTimerState.completed() = _Completed;

  const factory FocusTimerState.error(String message) = _Error;
}
