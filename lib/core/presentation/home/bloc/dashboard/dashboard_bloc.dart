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
    on<_FetchDashboardData>((event, emit) async {
      emit(_Loading());
      
      // Ambil data dari repository (Mengembalikan Either)
      final result = await _dashboardRepository.getDashboard();
      
      // Bongkar data Either dengan .fold() khas dartz
      result.fold(
        (failureMessage) => emit(_Error(failureMessage)),
        (dashboardData) => emit(_Success(dashboardData)),
      );
    });
  }
}
