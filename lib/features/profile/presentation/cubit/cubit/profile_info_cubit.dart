import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/profile/data/repos/profile_repo.dart';
import 'package:medical/features/profile/presentation/cubit/cubit/profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit(this._profileRepo) : super(ProfileInfoInitial());
 final ProfileRepo _profileRepo ;
  Future<void> fetchProfileData() async {
    emit(ProfileInfoLoading());
    final result = await _profileRepo.fetchProfileData();
    result.fold(
      (failure) => emit(ProfileInfoError(message: failure.errorMessage)),
      (userProfile) => emit(ProfileInfoSuccess(userProfile: userProfile)),
    );
  }

}
