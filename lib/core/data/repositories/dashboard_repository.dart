import 'package:dartz/dartz.dart';
import 'package:mino/core/data/datasource/dashboard_remote_datasource.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';


class DashboardRepository {
  final DashboardRemoteDatasource remoteDatasource;

  DashboardRepository({required this.remoteDatasource});

  Future<Either<String, DashboardResponseModel>> getDashboard() async {
    return await remoteDatasource.getDashboard();
  }
}