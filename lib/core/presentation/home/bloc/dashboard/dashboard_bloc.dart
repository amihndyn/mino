import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';
import 'package:mino/core/data/repositories/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc(this._dashboardRepository) : super(_Initial()) {
    
    // 1. HANDLER FETCH UTAMA
    on<_FetchDashboardData>((event, emit) async {
      emit(_Loading());
      final result = await _dashboardRepository.getDashboard();
      result.fold(
        (failureMessage) => emit(_Error(failureMessage)),
        (dashboardData) => emit(_Success(dashboardData)),
      );
    });

    // 2. HANDLER TOGGLE STATUS CENTANG HABIT
    on<_ToggleHabit>((event, emit) async {
      // Kirim request ke repository Laravel
      final result = await _dashboardRepository.toggleHabitStatus(event.userHabitId);
      
      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (success) async {
          add(const DashboardEvent.fetchDashboardData());
          // 🔥 SANGAT PENTING: Langsung tarik data dashboard terbaru 
          // tanpa emit(_Loading()) agar UI ter-refresh mulus tanpa kedip!
          final refreshResult = await _dashboardRepository.getDashboard();
          refreshResult.fold(
            (failureMessage) => emit(_Error(failureMessage)),
            (dashboardData) => emit(_Success(dashboardData)),
          );
        },
      );
    });

    // 3. HANDLER HAPUS HABIT
    on<_DeleteHabit>((event, emit) async {
      final result = await _dashboardRepository.deleteHabit(event.userHabitId);
      
      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (success) async {
          add(const DashboardEvent.fetchDashboardData());
          // Refresh data otomatis setelah item berhasil dihapus
          final refreshResult = await _dashboardRepository.getDashboard();
          refreshResult.fold(
            (failureMessage) => emit(_Error(failureMessage)),
            (dashboardData) => emit(_Success(dashboardData)),
          );
        },
      );
    });

    // 5. HANDLER TAMBAH/CREATE HABIT
    on<_AddHabit>((event, emit) async {
      // 🔥 PERBAIKAN: Cukup kirim event.name ke repository
      final result = await _dashboardRepository.addHabit(event.name);

      await result.fold(
        (failureMessage) async => emit(DashboardState.error(failureMessage)),
        (success) async {
          // 🔥 Auto refresh data dashboard agar habit baru langsung muncul di layar utama!
          final refreshResult = await _dashboardRepository.getDashboard();
          refreshResult.fold(
            (failureMessage) => emit(DashboardState.error(failureMessage)),
            (dashboardData) => emit(DashboardState.success(dashboardData)),
          );
        },
      );
    });

    // 🔥 6. HANDLER EDIT HABIT
    on<_EditHabit>((event, emit) async {
      // Kirim id dan nama baru ke repository
      final result = await _dashboardRepository.editHabit(event.userHabitId, event.newName);

      await result.fold(
        (failureMessage) async => emit(_Error(failureMessage)),
        (success) async {
          // 🔥 Auto refresh data dashboard agar nama habit langsung berubah di layar utama!
          final refreshResult = await _dashboardRepository.getDashboard();
          refreshResult.fold(
            (failureMessage) => emit(_Error(failureMessage)),
            (dashboardData) => emit(_Success(dashboardData)),
          );
        },
      );
    });

  }
}
