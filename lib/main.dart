import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/api_constant.dart';
import 'package:medical/features/login/data/repository/auth_repository.dart';
import 'package:medical/features/login/presentation/cubit/auth_cubit.dart';

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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityStatus>(
      listener: (context, state) {
        if (state == ConnectivityStatus.disconnected) {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (_) => OfflineScreen()));
        }
      },
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return BlocProvider(
            create: (context) =>
                AuthCubit(AuthRepository(ApiService(dio: Dio()))),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,

              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
