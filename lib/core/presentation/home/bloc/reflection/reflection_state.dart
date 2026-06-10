part of 'reflection_bloc.dart';

@freezed
class ReflectionState with _$ReflectionState {
  const factory ReflectionState.initial() = _Initial;
  const factory ReflectionState.loading() = _Loading;

  // State saat sukses memuat seluruh riwayat jurnal
  const factory ReflectionState.loaded(List<Reflection> reflections) = _Loaded;

  // State saat sukses mengecek hari ini (bisa berisi objek Reflection atau null jika belum isi)
  const factory ReflectionState.todayLoaded(Reflection? reflection) = _TodayLoaded;

  // State saat sukses menyimpan atau mengupdate jurnal
  const factory ReflectionState.saveSuccess(Reflection reflection) = _SaveSuccess;

  const factory ReflectionState.error(String message) = _Error;
}