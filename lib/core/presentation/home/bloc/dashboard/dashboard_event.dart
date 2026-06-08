part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = _Started;
  const factory DashboardEvent.fetchDashboardData() = _FetchDashboardData;
  const factory DashboardEvent.toggleHabit(int userHabitId) = _ToggleHabit;
  const factory DashboardEvent.deleteHabit(int userHabitId) = _DeleteHabit;
  const factory DashboardEvent.addHabit(String name) = _AddHabit;
  // 🔥 TAMBAHKAN BARIS INI DI DALAM class DashboardEvent
  const factory DashboardEvent.editHabit(int userHabitId, String newName) = _EditHabit;
}
