import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';
import 'package:mino/core/data/repositories/dashboard_repository.dart';
import 'package:mino/core/data/datasource/dashboard_local_datasource.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;
  final DashboardLocalDatasource _localDatasource = DashboardLocalDatasource.instance;

  // 🔥 Tambahkan variabel ini untuk mengingat ID bulan yang sedang aktif di UI
  int? _currentSelectedMonthId;

  DashboardBloc(this._dashboardRepository) : super(_Initial()) {
    
    // Helper function untuk mengambil data ulang secara benar
    Future<void> _reloadDataAfterAction(Emitter<DashboardState> emit) async {
      // Kita panggil repository getDashboard dengan membawa ID bulan yang sedang aktif!
      final result = await _dashboardRepository.getDashboard(month: _currentSelectedMonthId);
      result.fold(
        (failureMessage) => emit(_Error(failureMessage)),
        (dashboardData) => emit(_Success(dashboardData)),
      );
    }

    // 1. FETCH UTAMA
    on<_FetchDashboardData>((event, emit) async {
      emit(_Loading());
      
      // 🔥 Simpan ID bulan yang sedang direquest ke dalam variabel private bloc
      _currentSelectedMonthId = event.month;

      final result = await _dashboardRepository.getDashboard(month: event.month);
      
      result.fold(
        (failureMessage) => emit(_Error(failureMessage)),
        (dashboardData) => emit(_Success(dashboardData)),
      );
    });

    // 2. HANDLER TOGGLE STATUS CENTANG HABIT
    on<_ToggleHabit>((event, emit) async {
      final result = await _dashboardRepository.toggleHabitStatus(event.userHabitId, event.currentStatus);
      
      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (success) async {
          // 🔥 Ambil data terupdate dari server/lokal secara cerdas sesuai bulan yang aktif
          await _reloadDataAfterAction(emit);
        },
      );
    });

    // 3. HANDLER HAPUS HABIT
    on<_DeleteHabit>((event, emit) async {
      final result = await _dashboardRepository.deleteHabit(event.userHabitId);
      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (success) async {
          await _reloadDataAfterAction(emit);
        },
      );
    });

    // 4. HANDLER TAMBAH/CREATE HABIT
    on<_AddHabit>((event, emit) async {
      final result = await _dashboardRepository.addHabit(event.name);
      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (success) async {
          await _reloadDataAfterAction(emit);
        },
      );
    });

    // 5. HANDLER EDIT HABIT
    on<_EditHabit>((event, emit) async {
      final result = await _dashboardRepository.editHabit(event.userHabitId, event.newName);
      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (success) async {
          await _reloadDataAfterAction(emit);
        },
      );
    });
  }
}