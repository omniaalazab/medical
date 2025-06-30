import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/login/data/models/otp_response_model.dart';
import 'package:medical/features/login/data/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  void sendPhone(String phone) async {
    emit(AuthLoading());
    try {
      // final result = await repository.sendPhone(phone);
      if (phone.length == 11) {
        emit(
          AuthSuccess(
            OtpResponse(status: true, message: "OTP sent", data: null),
          ),
        );
      }
    } catch (e) {
      emit(AuthError("Phone number must be 11 digits"));
      // modify to show sucess login
    }
  }

  void verifyOtp(String phone, String otp) async {
    emit(AuthLoading());
    try {
      // final result = await repository.verifyOtp(phone, otp);
      if (otp.isNotEmpty) {
        emit(
          AuthSuccess(
            OtpResponse(status: true, message: "OTP verified", data: null),
          ),
        );
      }
    } catch (e) {
      emit(AuthError("Invalid OTP"));
      // modify to show sucess login
    }
  }
}
