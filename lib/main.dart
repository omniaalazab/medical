import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:medical/features/login/presentation/view/splash_screen.dart';

import 'package:sizer/sizer.dart';

void main() {
  runApp(
    MyApp(), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          home: SplashScreen(),
        );
      },
    );
  }
}
