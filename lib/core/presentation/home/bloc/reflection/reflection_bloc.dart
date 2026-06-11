import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mino/core/data/model/request/reflection_request_model.dart';
import 'package:mino/core/data/model/response/reflection_response_model.dart';
import 'package:mino/core/data/repositories/reflection_repository.dart'; // Sesuaikan path-nya

part 'reflection_event.dart';
part 'reflection_state.dart';
part 'reflection_bloc.freezed.dart';

class ReflectionBloc extends Bloc<ReflectionEvent, ReflectionState> {
  final ReflectionRepository _repository;

  ReflectionBloc(this._repository) : super(const _Initial()) {
    
    // HANDLER 1: GET ALL REFLECTIONS (Histori Jurnal)
    on<_GetReflections>((event, emit) async {
      emit(const _Loading());
      final result = await _repository.getReflections();
      
      result.fold(
        (failure) => emit(_Error(failure)),
        (reflections) => emit(_Loaded(reflections)),
      );
    });

    // HANDLER 2: GET TODAY REFLECTION (Cek Jurnal Hari Ini)
    on<_GetTodayReflection>((event, emit) async {
      emit(const _Loading());
      final result = await _repository.getTodayReflection();
      
      result.fold(
        (failure) => emit(_Error(failure)),
        (reflection) => emit(_TodayLoaded(reflection)),
      );
    });

    // HANDLER 3: SAVE REFLECTION (Simpan/Update Jurnal)
    on<_SaveReflection>((event, emit) async {
      emit(const _Loading());
      final result = await _repository.saveReflection(event.request);
      
      result.fold(
        (failure) => emit(_Error(failure)),
        (reflection) => emit(_SaveSuccess(reflection)),
      );
    });
    
  }
}