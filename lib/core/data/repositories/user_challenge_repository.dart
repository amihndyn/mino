import 'package:dartz/dartz.dart';

import 'package:mino/core/data/datasource/user_challenge_remote_datasource.dart';

import 'package:mino/core/data/datasource/user_challenge_local_datasource.dart';

import 'package:mino/core/data/model/request/user_challenge_request_model.dart';

import 'package:mino/core/data/model/response/user_challenge_response_model.dart';



class UserChallengeRepository {

  final UserChallengeRemoteDatasource remoteDatasource;

  final UserChallengeLocalDatasource localDatasource;



  UserChallengeRepository({

    required this.remoteDatasource,

    required this.localDatasource,

  });



  // Fetch Utama (Mendukung Offline)

  Future<Either<String, List<UserChallenge>>> getUserChallenges() async {

    try {

      final remoteData = await remoteDatasource.getUserChallenges();

      await localDatasource.cacheUserChallenges(remoteData);

      return Right(remoteData);

    } catch (e) {

      final localData = await localDatasource.getCachedUserChallenges();

      if (localData.isNotEmpty) {

        return Right(localData);

      }

      return Left(e.toString());

    }

  }



  // Join Challenge Baru

  Future<Either<String, bool>> joinChallenge(UserChallengeRequestModel requestModel) async {

    try {

      final result = await remoteDatasource.joinChallenge(requestModel);

      return Right(result);

    } catch (e) {
      print("🚨 ERROR JOIN CHALLENGE: $e");

      return Left(e.toString());

    }

  }



  // Tombol Centang Harian

  Future<Either<String, UserChallenge>> checkInChallenge(int id) async {

    try {

      final result = await remoteDatasource.checkInChallenge(id);

      return Right(result);

    } catch (e) {

      return Left(e.toString());

    }

  }



  // Tebus Diamond (Revive)

  Future<Either<String, UserChallenge>> reviveChallenge(int id) async {

    try {

      final result = await remoteDatasource.reviveChallenge(id);

      return Right(result);

    } catch (e) {

      return Left(e.toString());

    }

  }

  // Hapus atau Keluar dari Challenge
  Future<Either<String, String>> deleteUserChallenge(int id) async {
    try {
      // 🔥 FIX: Menggunakan remoteDatasource (tanpa underscore) sesuai deklarasi class kamu
      final response = await remoteDatasource.deleteUserChallenge(id);
      
      // Opsional: Jika kamu ingin langsung memperbarui data lokal saat offline
      // Kamu bisa memicu fetch ulang di sini atau membiarkan BLoC yang memicu fetch setelah fungsi ini sukses.
      
      return Right(response);
    } catch (e) {
      // Menghilangkan tulisan "Exception: " di awal teks error jika ada
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      return Left(errorMessage);
    }
  }

} 

