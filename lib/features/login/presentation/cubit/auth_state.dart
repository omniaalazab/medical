import 'package:medical/features/login/data/models/otp_response_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final OtpResponse response;
  AuthSuccess(this.response);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
