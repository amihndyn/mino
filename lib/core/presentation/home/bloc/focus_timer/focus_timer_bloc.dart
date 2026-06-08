import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'focus_timer_event.dart';
part 'focus_timer_state.dart';
part '../bloc/focus_timer_bloc.freezed.dart';

class FocusTimerBloc extends Bloc<FocusTimerEvent, FocusTimerState> {
  FocusTimerBloc() : super(_Initial()) {
    on<FocusTimerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
