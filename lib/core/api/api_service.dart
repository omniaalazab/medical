import 'package:dio/dio.dart';
import 'package:medical/features/login/data/models/otp_response_model.dart';

class ApiService {
  final Dio _dio = Dio();

  
  Dio get dio => _dio;

  Future<OtpResponse> sendPhoneNumber(String phone) async {
    try {
      final response = await _dio.post(
        'https://medical.digital-vision-solutions.com/api/auth/send-otp',
        data: {'phone': phone},
      );

      return OtpResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to send phone number: $e');
    }
  }

  Future<OtpResponse> verifyOTP(String phone, String otp) async {
    try {
      final response = await _dio.post(
        'https://medical.digital-vision-solutions.com/api/auth/verify-otp',
        data: {
          'phone': phone,
          'otp': otp,
        },
      );

      return OtpResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }
}
