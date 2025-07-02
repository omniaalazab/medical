import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical/features/offline/presentaion/view/offline.dart';
import 'package:medical/main.dart';
// wherever navigatorKey is defined

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

  dio.interceptors.addAll([
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ),
    InterceptorsWrapper(
      onError: (DioException e, handler) {
        if (e.type == DioExceptionType.connectionError ||
            e.error.toString().contains('SocketException')) {
          final context = navigatorKey.currentContext;
          if (context != null) {
            // Avoid pushing multiple times
            bool isOfflineAlready =
                ModalRoute.of(context)?.settings.name == '/offline';

            if (!isOfflineAlready) {
              navigatorKey.currentState?.push(
                MaterialPageRoute(
                  settings: const RouteSettings(name: '/offline'),
                  builder: (_) => const OfflineScreen(),
                ),
              );
            }
          }
        }

        return handler.next(e); // Let Dio continue passing the error
      },
    ),
  ]);

  return dio;
}
