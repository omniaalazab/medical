import 'package:medical/core/api/api_services.dart';
import 'package:medical/features/login/data/models/otp_response_model.dart';


class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<OtpResponse> sendPhone(String phone) async {
    return await apiService.sendPhoneNumber(phone);
  }

  Future<OtpResponse> verifyOtp(String phone, String otp) async {
    return await apiService.verifyOTP(phone, otp);
  }
}
