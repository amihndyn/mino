import 'package:dartz/dartz.dart';
import 'package:mino/core/data/datasource/focus_timer_remote_datasource.dart';

class FocusTimerRepository {
  final FocusTimerRemoteDatasource remoteDatasource;

  FocusTimerRepository({required this.remoteDatasource});

  Future<Either<String, int>> startFocus({
    int? userHabitId,
    int? userChallengeId,
  }) async {
    try {
      final result = await remoteDatasource.startFocus(
        userHabitId: userHabitId,
        userChallengeId: userChallengeId,
      );

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> completeFocus({required int timerId, required int durationMinutes}) async {
    try {
      final result = await remoteDatasource.completeFocus(timerId: timerId, durationMinutes: durationMinutes);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}