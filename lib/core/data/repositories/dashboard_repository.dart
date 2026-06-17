import 'package:dartz/dartz.dart';
import 'package:mino/core/data/datasource/dashboard_remote_datasource.dart';
import 'package:mino/core/data/datasource/dashboard_local_datasource.dart'; 
import 'package:mino/core/data/model/response/dashboard_response.dart';

class DashboardRepository {
  final DashboardRemoteDatasource remoteDatasource;
  final DashboardLocalDatasource localDatasource = DashboardLocalDatasource.instance;

  DashboardRepository({required this.remoteDatasource});

  // --- Fungsi getDashboard tetap aman ---
  Future<Either<String, DashboardResponseModel>> getDashboard({int? month}) async {
    try {
      final remoteResult = await remoteDatasource.getDashboard(month: month);

      return await remoteResult.fold(
        (error) async {
          print("⚠️ Remote gagal ($error), mengambil data dari cache lokal...");
          final localResult = await localDatasource.getLocalDashboard();
          return localResult; 
        },
        (remoteData) async {
          await localDatasource.cacheDashboard(remoteData);
          return Right(remoteData);
        },
      );
    } catch (e) {
      final localResult = await localDatasource.getLocalDashboard();
      return localResult;
    }
  }

  // 🔥 PERBAIKAN DI SINI: Oper currentStatus ke remoteDatasource
  Future<Either<String, bool>> toggleHabitStatus(int userHabitId, bool currentStatus) async {
    try {
      // Tambahkan parameter kedua (currentStatus) sesuai perubahan di remote datasource sebelumnya
      final result = await remoteDatasource.toggleHabitStatus(userHabitId, currentStatus);
      await localDatasource.toggleLocalHabitStatus(userHabitId, currentStatus);
      return Right(result);
    } catch (e) {
      final localResult = await localDatasource.toggleLocalHabitStatus(userHabitId, currentStatus);
      if (localResult) return const Right(true);
      return Left("Gagal mengubah status habit secara offline: ${e.toString()}");
    }
  }

  // --- Fungsi delete, add, dan edit tetap di bawah ini ---
  Future<Either<String, bool>> deleteHabit(int userHabitId) async {
    try {
      final result = await remoteDatasource.deleteHabit(userHabitId);
      await localDatasource.deleteLocalHabit(userHabitId);
      return Right(result);
    } catch (e) {
      final localResult = await localDatasource.deleteLocalHabit(userHabitId);
      if (localResult) return const Right(true);
      return Left("Gagal menghapus habit secara offline: ${e.toString()}");
    }
  }

  Future<Either<String, bool>> addHabit(String name) async {
    try {
      final result = await remoteDatasource.addHabit(name);
      await localDatasource.addLocalHabit(name);
      return Right(result);
    } catch (e) {
      final localResult = await localDatasource.addLocalHabit(name);
      if (localResult) return const Right(true);
      return Left("Gagal menambah habit secara offline: ${e.toString()}");
    }
  }

  Future<Either<String, bool>> editHabit(int userHabitId, String newName) async {
    try {
      final result = await remoteDatasource.editHabit(userHabitId, newName);
      await localDatasource.editLocalHabit(userHabitId, newName);
      return Right(result);
    } catch (e) {
      final localResult = await localDatasource.editLocalHabit(userHabitId, newName);
      if (localResult) return const Right(true);
      return Left("Gagal mengubah nama habit secara offline: ${e.toString()}");
    }
  }
}