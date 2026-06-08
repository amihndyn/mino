part of 'focus_timer_bloc.dart';

@freezed
class FocusTimerEvent with _$FocusTimerEvent {
  // Event saat tombol "Start" ditekan
  const factory FocusTimerEvent.startFocus({int? userHabitId}) = _StartFocus;

  // Event saat timer mencapai 00:00 atau tombol "Selesai" ditekan
  const factory FocusTimerEvent.completeFocus({
    required int timerId,
    required int durationMinutes,
  }) = _CompleteFocus;
}
