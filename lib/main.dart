import 'package:flutter/material.dart';
import 'package:medical/features/home/presentation/view/home.dart';
import 'package:medical/features/login/presentation/view/profile_screen.dart';
import 'package:medical/features/product_details/presentation/view/product_details.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(const MyApp());
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
          home: ProfileScreen(),
        );
      },
    );
  }
}
