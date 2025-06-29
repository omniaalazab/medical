import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/profile/data/model/user_profile/data.dart';
import 'package:medical/features/profile/data/repos/profile_repo.dart';
import 'package:medical/features/profile/presentation/cubit/cubit/profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit(this._profileRepo) : super(ProfileInfoInitial());
  final ProfileRepo _profileRepo;
  Future<void> fetchProfileData() async {
    emit(ProfileInfoLoading());
    final result = await _profileRepo.fetchProfileData();
    result.fold(
      (failure) => emit(ProfileInfoError(message: failure.errorMessage)),
      (userProfile) => emit(ProfileInfoSuccess(userProfile: userProfile.data!)),
    );
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  String genderController = "male";
  TextEditingController bioController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> updateProfileData({required Data userProfile}) async {
    emit(ProfileInfoLoading());
    final result = await _profileRepo.updateProfileData(userProfile);
    result.fold(
      (failure) => emit(ProfileInfoError(message: failure.errorMessage)),
      (success) => emit(ProfileInfoUpdateSuccess()),
    );
  }
}
