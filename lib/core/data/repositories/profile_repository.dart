import 'package:dartz/dartz.dart';
import 'package:mino/core/data/datasource/profile_remote_datasource.dart';
import 'package:mino/core/data/model/request/profile_request_model.dart';
import 'package:mino/core/data/model/response/profile_response_model.dart';

class ProfileRepository {
  final ProfileRemoteDatasource _datasource;

  ProfileRepository(this._datasource);

  /// Mengambil data profile terbaru dari server
  Future<Either<String, ProfileResponseModel>> getProfile() async {
    try {
      final result = await _datasource.getProfile();
      return Right(result);
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Update profile data beserta upload foto menggunakan Multipart
  Future<Either<String, ProfileResponseModel>> updateProfile(
    ProfileRequestModel request,
    String? imagePath,
  ) async {
    try {
      final result = await _datasource.updateProfile(request, imagePath);
      return Right(result);
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }
}