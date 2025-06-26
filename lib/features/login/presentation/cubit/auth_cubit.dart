import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/login/data/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  void sendPhone(String phone) async {
    emit(AuthLoading());
    try {
      final result = await repository.sendPhone(phone);
      emit(AuthSuccess(result));
    } catch (e) {
      emit(AuthError("Failed to send phone number"));
    }
  }

  void verifyOtp(String phone, String otp) async {
    emit(AuthLoading());
    try {
      final result = await repository.verifyOtp(phone, otp);
      emit(AuthSuccess(result));
    } catch (e) {
      emit(AuthError("Code verification failed"));
    }
  }
}
