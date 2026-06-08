part of 'focus_timer_bloc.dart';

@freezed
class FocusTimerEvent with _$FocusTimerEvent {
  const factory FocusTimerEvent.started() = _Started;
}