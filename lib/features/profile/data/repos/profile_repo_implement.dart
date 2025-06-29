import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medical/core/api/endpoints.dart';
import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/errors/failure.dart';
import 'package:medical/features/profile/data/model/user_profile/data.dart';
import 'package:medical/features/profile/data/model/user_profile/user_profile.dart';
import 'package:medical/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImplement extends ProfileRepo {
  final ApiService _apiService;

  ProfileRepoImplement({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<Either<Failure, UserProfile>> fetchProfileData() async {
    try {
      var data = await _apiService.get(endPoint: Endpoints.profile);
      UserProfile userProfile = UserProfile.fromJson(data['data']);
      return right(userProfile);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, bool>> deleteImage({required String userId}) async {

  // }

  @override
  Future<Either<Failure, bool>> updateProfileData(Data profileData) async {
    try {
      final response = await _apiService.post(
        endPoint: Endpoints.updateProfile,
        body: profileData.toJson(),
      );
      return right(true);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(errorMessage: e.toString()));
      }
    }
  }
}
