import 'package:dartz/dartz.dart';
import 'package:mino/core/data/datasource/dashboard_remote_datasource.dart';
// 🔥 Tambahkan import datasource lokal di sini (sesuaikan dengan path folder kamu)
import 'package:mino/core/data/datasource/dashboard_local_datasource.dart'; 
import 'package:mino/core/data/model/response/dashboard_response.dart';

class DashboardRepository {
  final DashboardRemoteDatasource remoteDatasource;
  // 🔥 Inisialisasi instance local datasource
  final DashboardLocalDatasource localDatasource = DashboardLocalDatasource.instance;

  DashboardRepository({required this.remoteDatasource});

  // 1. AMBIL DATA DASHBOARD
// 1. EDIT SEMENTARA DI FILE DASHBOARD_REPOSITORY.DART KAMU
// 1. AMBIL DATA DASHBOARD (Sudah ditambahkan parameter month)
  Future<Either<String, DashboardResponseModel>> getDashboard({int? month}) async {
    try {
      // 🔥 Meneruskan parameter month ke remote datasource
      final remoteResult = await remoteDatasource.getDashboard(month: month);

      return remoteResult.fold(
        (error) {
          return Left("Error Server: $error");
        },
        (remoteData) async {
          await localDatasource.cacheDashboard(remoteData);
          return Right(remoteData);
        },
      );
    } catch (e) {
      return Left("Crash Terjadi: ${e.toString()}");
    }
  }

  // 2. TOGGLE STATUS HABIT
  Future<Either<String, bool>> toggleHabitStatus(int userHabitId, bool currentStatus) async {
    try {
      // Coba tembak ke server dulu
      final result = await remoteDatasource.toggleHabitStatus(userHabitId);
      
      // Jika server sukses, update juga data di SQLite lokal agar tetap sinkron
      await localDatasource.toggleLocalHabitStatus(userHabitId, currentStatus);
      return Right(result);
    } catch (e) {
      // ❌ JIKA OFFLINE, langsung manipulasi database lokal SQLite
      final localResult = await localDatasource.toggleLocalHabitStatus(userHabitId, currentStatus);
      if (localResult) {
        return const Right(true);
      } else {
        return Left("Gagal mengubah status habit secara offline: ${e.toString()}");
      }
    }
  }

  // 3. DELETE HABIT
  Future<Either<String, bool>> deleteHabit(int userHabitId) async {
    try {
      final result = await remoteDatasource.deleteHabit(userHabitId);
      // Sinkronkan ke lokal jika sukses online
      await localDatasource.deleteLocalHabit(userHabitId);
      return Right(result);
    } catch (e) {
      // ❌ JIKA OFFLINE, hapus dari database lokal SQLite
      final localResult = await localDatasource.deleteLocalHabit(userHabitId);
      if (localResult) {
        return const Right(true);
      } else {
        return Left("Gagal menghapus habit secara offline: ${e.toString()}");
      }
    }
  }

  // 4. ADD HABIT
  Future<Either<String, bool>> addHabit(String name) async {
    try {
      final result = await remoteDatasource.addHabit(name);
      // Catatan: Jika online, idealnya kita panggil getDashboard lagi nanti untuk memperbarui lokal.
      // Namun untuk berjaga-jaga, kita tambahkan ke lokal juga.
      await localDatasource.addLocalHabit(name);
      return Right(result);
    } catch (e) {
      // ❌ JIKA OFFLINE, tambah ke database lokal SQLite
      final localResult = await localDatasource.addLocalHabit(name);
      if (localResult) {
        return const Right(true);
      } else {
        return Left("Gagal menambah habit secara offline: ${e.toString()}");
      }
    }
  }

  // 5. EDIT HABIT
  Future<Either<String, bool>> editHabit(int userHabitId, String newName) async {
    try {
      final result = await remoteDatasource.editHabit(userHabitId, newName);
      // Sinkronkan ke lokal jika sukses online
      await localDatasource.editLocalHabit(userHabitId, newName);
      return Right(result);
    } catch (e) {
      // ❌ JIKA OFFLINE, edit di database lokal SQLite
      final localResult = await localDatasource.editLocalHabit(userHabitId, newName);
      if (localResult) {
        return const Right(true);
      } else {
        return Left("Gagal mengubah nama habit secara offline: ${e.toString()}");
      }
    }
  }
}