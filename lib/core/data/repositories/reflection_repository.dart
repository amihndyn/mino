import 'package:dartz/dartz.dart';
import 'package:mino/core/data/datasource/reflection_remote_datasource.dart';

import 'package:mino/core/data/model/request/reflection_request_model.dart';
import 'package:mino/core/data/model/response/reflection_response_model.dart';

abstract class ReflectionRepository {
  Future<Either<String, List<Reflection>>> getReflections();
  Future<Either<String, Reflection?>> getTodayReflection();
  Future<Either<String, Reflection>> saveReflection(ReflectionRequestModel request);
}

class ReflectionRepositoryImpl implements ReflectionRepository {
  final ReflectionRemoteDatasource remoteDatasource;

  ReflectionRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<String, List<Reflection>>> getReflections() async {
    try {
      final result = await remoteDatasource.getReflections();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Reflection?>> getTodayReflection() async {
    try {
      final result = await remoteDatasource.getTodayReflection();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Reflection>> saveReflection(ReflectionRequestModel request) async {
    try {
      final result = await remoteDatasource.saveReflection(request);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}