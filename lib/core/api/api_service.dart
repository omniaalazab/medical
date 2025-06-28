// import 'package:dio/dio.dart';
// import 'package:medical/core/api/endpoints.dart';
// import 'package:medical/core/models/product_model.dart';
// import 'package:medical/features/login/data/models/otp_response_model.dart';

// class ApiService {
//   final Dio _dio = Dio();

//   Dio get dio => _dio;

//   Future<OtpResponse> sendPhoneNumber(String phone) async {
//     try {
//       final response = await _dio.post(
//         'https://medical.digital-vision-solutions.com/api/auth/send-otp',
//         data: {'phone': phone},
//       );

//       return OtpResponse.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to send phone number: $e');
//     }
//   }

//   Future<OtpResponse> verifyOTP(String phone, String otp) async {
//     try {
//       final response = await _dio.post(
//         'https://medical.digital-vision-solutions.com/api/auth/verify-otp',
//         data: {
//           'phone': phone,
//           'otp': otp,
//         },
//       );

//       return OtpResponse.fromJson(response.data);
//     } catch (e) {
//       throw Exception('Failed to verify OTP: $e');
//     }
//   }
//    Future<dynamic> get( {required String endPoint}) async {
//     final response = await dio.get('${Endpoints.baseUrl}$endPoint');
//     if (response.statusCode == 200) {
//     return response.data ;

//   }}

//   Future<ProductModel> fetchSingleProduct(int id) async {
//     final response = await dio.get('${Endpoints.baseUrl}/products/$id');

//     if (response.statusCode == 200) {
//       final data = response.data['data'];
//       return ProductModel.fromJson(data);
//     } else {
//       final error = response.data['message'] ?? 'Unknown server error';
//       throw Exception('Failed to load product details: $error');
//     }
//   }
// }
