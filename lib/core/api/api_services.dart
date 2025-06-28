import 'package:dio/dio.dart';
import 'package:medical/core/api/endpoints.dart';

import 'package:medical/core/models/product_model/product_model.dart';
import 'package:medical/features/login/data/models/otp_response_model.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<OtpResponse> sendPhoneNumber(String phone) async {
    try {
      final response = await dio.post(
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
      final response = await dio.post(
        'https://medical.digital-vision-solutions.com/api/auth/verify-otp',
        data: {'phone': phone, 'otp': otp},
      );

      return OtpResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  Future<dynamic> get({required String endPoint}) async {
    try {
      final response = await dio.get('${Endpoints.baseUrl}$endPoint');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<ProductUnifiedModel> fetchSingleProduct(int id) async {
    try {
      print('Fetching product with ID: $id');
      final response = await dio.get('${Endpoints.baseUrl}/products/$id');

      print('Response status: ${response.statusCode}');
      print('Full Response data: ${response.data}');

      if (response.statusCode == 200) {
        // Check the actual structure of your API response
        final responseData = response.data;

        // Option 1: If your API returns { "data": { product_fields... } }
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          return ProductUnifiedModel.fromJson(responseData);
        }
        // Option 2: If your API returns the product directly { id, name, description... }
        else if (responseData is Map<String, dynamic>) {
          // Wrap the response in a "data" structure to match your model
          return ProductUnifiedModel.fromJson({'data': responseData});
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else {
        final error = response.data['message'] ?? 'Unknown server error';
        throw Exception('Failed to load product details: $error');
      }
    } catch (e) {
      print('Error fetching product: $e');
      if (e is DioException) {
        if (e.response != null) {
          print('Error response status: ${e.response?.statusCode}');
          print('Error response data: ${e.response?.data}');
          throw Exception(
            'Server error: ${e.response?.statusCode} - ${e.response?.data}',
          );
        } else {
          throw Exception('Network error: ${e.message}');
        }
      }
      throw Exception('Failed to fetch product: $e');
    }
  }
}
