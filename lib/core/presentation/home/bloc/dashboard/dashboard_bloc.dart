import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';
import 'package:mino/core/data/repositories/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;
  int? _currentSelectedMonthId;

  DashboardBloc(this._dashboardRepository)
    : super(const DashboardState.initial()) {
    on<_FetchDashboardData>(_onFetchDashboardData);
    on<_ToggleHabit>(_onToggleHabit);
    on<_AddHabit>(_onAddHabit);
    on<_DeleteHabit>(_onDeleteHabit);
    on<_EditHabit>(_onEditHabit);
  }

  Future<void> _onFetchDashboardData(
    _FetchDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardState.loading());

    _currentSelectedMonthId = event.month;

    final result = await _dashboardRepository.getDashboard(month: event.month);

    result.fold(
      (failure) => emit(DashboardState.error(failure)),
      (data) => emit(DashboardState.success(data)),
    );
  }

  // 2. Buat fungsi untuk menangani penambahan habit
  Future<void> _onAddHabit(
    _AddHabit event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      // Panggil fungsi addHabit di repository kamu (sesuaikan nama fungsinya dengan yang ada di Laravel/Repo kamu)
      await _dashboardRepository.addHabit(event.name); 

      // Setelah berhasil add, reload data dashboard otomatis
      await _reloadData(emit);
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }

  Future<void> _onToggleHabit(
    _ToggleHabit event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      await _dashboardRepository.toggleHabitStatus(
        event.userHabitId,
        event.currentStatus,
      );

      await _reloadData(emit);
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }

  Future<void> _onDeleteHabit(
    _DeleteHabit event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(const DashboardState.loading());

      await _dashboardRepository.deleteHabit(event.userHabitId);

      await _reloadData(emit);
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }

  Future<void> _onEditHabit(
    _EditHabit event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(const DashboardState.loading());

      await _dashboardRepository.editHabit(event.userHabitId, event.newName);
      await _reloadData(emit);
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }

  /// ========================
  /// RELOAD DATA (FIXED SAFE)
  /// ========================
  Future<void> _reloadData(Emitter<DashboardState> emit) async {
    final result = await _dashboardRepository.getDashboard(
      month: _currentSelectedMonthId ?? 1,
    );

    result.fold(
      (failure) => emit(DashboardState.error(failure)),
      (data) => emit(DashboardState.success(data)),
    );
  }
}
