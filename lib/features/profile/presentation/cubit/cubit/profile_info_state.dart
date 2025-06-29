import 'package:medical/features/profile/data/model/user_profile/data.dart';

sealed class ProfileInfoState {}

final class ProfileInfoInitial extends ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}

final class ProfileInfoSuccess extends ProfileInfoState {
  final Data userProfile;

  ProfileInfoSuccess({required this.userProfile});
}

final class ProfileInfoError extends ProfileInfoState {
  final String message;
  ProfileInfoError({required this.message});
}

final class ProfileInfoUpdateSuccess extends ProfileInfoState {}
