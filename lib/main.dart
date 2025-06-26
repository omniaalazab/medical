import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
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
=======
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medical/core/api_constant.dart';

import 'package:medical/features/login/presentation/view/splash_screen.dart';
import 'package:medical/features/offline/presentaion/cubit/offline_cubit.dart';
import 'package:medical/features/offline/presentaion/view/offline.dart';
import 'package:medical/core/dependency_injection/service_locator.dart';

import 'package:sizer/sizer.dart';

void main() {
  setupLocator();
  ();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) =>
          BlocProvider(create: (_) => ConnectivityCubit(), child: MyApp()),
    ),
  );
  Stripe.publishableKey = APIKey.stripePublishableKey;
  WidgetsFlutterBinding.ensureInitialized();
>>>>>>> 5ef7d698ad381f02022bdf93ade92a805021ebce
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  final Dio dio;

  const MyApp({super.key, required this.apiService, required this.dio});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return BlocListener<ConnectivityCubit, ConnectivityStatus>(
      listener: (context, state) {
        if (state == ConnectivityStatus.disconnected) {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (_) => OfflineScreen()));
        }
>>>>>>> 5ef7d698ad381f02022bdf93ade92a805021ebce
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
