import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/api/api_service.dart';
import 'package:medical/features/login/data/repository/auth_repository.dart';
import 'package:medical/features/login/presentation/cubit/auth_cubit.dart';
import 'package:medical/features/login/presentation/view/splash_screen.dart';
import 'package:medical/features/notification/cubit/notification_cubit.dart';
import 'package:medical/features/notification/data/repository/notification_repository.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart';

void main() {
  final dio = Dio(); 
  final apiService = ApiService(); 

  runApp(MyApp(apiService: apiService, dio: dio));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  final Dio dio;

  const MyApp({super.key, required this.apiService, required this.dio});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthCubit(AuthRepository(apiService)),
            ),
            BlocProvider(
              create: (_) => NotificationCubit(
                NotificationRepository(apiService, dio: dio),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
