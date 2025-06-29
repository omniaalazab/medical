import 'package:dartz/dartz.dart';
import 'package:medical/core/errors/failure.dart';
import 'package:medical/features/profile/data/model/user_profile/data.dart';
import 'package:medical/features/profile/data/model/user_profile/user_profile.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserProfile>> fetchProfileData();
  Future<Either<Failure, bool>> updateProfileData(Data profileData);
  // Future<Either<Failure, bool>> deleteImage({required String useerId});
}
