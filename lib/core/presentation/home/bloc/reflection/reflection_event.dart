part of 'reflection_bloc.dart';

@freezed
class ReflectionEvent with _$ReflectionEvent {
  // Event untuk mengambil seluruh riwayat jurnal user
  const factory ReflectionEvent.getReflections() = _GetReflections;

  // Event untuk mengecek apakah hari ini user sudah mengisi jurnal atau belum
  const factory ReflectionEvent.getTodayReflection() = _GetTodayReflection;

  // Event untuk menyimpan jurnal baru atau meng-update jurnal hari ini
  const factory ReflectionEvent.saveReflection(ReflectionRequestModel request) = _SaveReflection;
}