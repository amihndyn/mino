import 'package:dartz/dartz.dart';
import 'package:mino/core/data/datasource/dashboard_remote_datasource.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';


class DashboardRepository {
  final DashboardRemoteDatasource remoteDatasource;

  DashboardRepository({required this.remoteDatasource});

  Future<Either<String, DashboardResponseModel>> getDashboard() async {
    return await remoteDatasource.getDashboard();
  }

  // Tambahkan di dalam class DashboardRepository
Future<Either<String, bool>> toggleHabitStatus(int userHabitId) async {
  try {
    final result = await remoteDatasource.toggleHabitStatus(userHabitId);
    return Right(result);
  } catch (e) {
    return Left(e.toString());
  }
}

Future<Either<String, bool>> deleteHabit(int userHabitId) async {
  try {
    final result = await remoteDatasource.deleteHabit(userHabitId);
    return Right(result);
  } catch (e) {
    return Left(e.toString());
  }
}

// 🔥 PERBAIKAN: Parameter disederhanakan menjadi String name saja
  // Dan pastikan memanggil remoteDatasource (ada huruf 'e' di belakangnya)
  Future<Either<String, bool>> addHabit(String name) async {
    try {
      final result = await remoteDatasource.addHabit(name); // <-- Di sini sudah diperbaiki typo-nya
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // 🔥 TAMBAHAN UNTUK EDIT HABIT
  Future<Either<String, bool>> editHabit(int userHabitId, String newName) async {
    try {
      final result = await remoteDatasource.editHabit(userHabitId, newName);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}