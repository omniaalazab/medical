import 'package:dio/dio.dart';

Dio createDioWithAuth() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://medical.digital-vision-solutions.com/api/',
      headers: {
        'Authorization':
            'Bearer 1|E2pejsYto9qBOH9vwBqpfulKGFYHR0G98A2fQmxy01cbba53',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ),
  );

  return dio;
}
