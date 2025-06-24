import 'package:flutter/material.dart';
import 'package:medical/features/login/presentation/view/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => OnboardingScreen()),
);
 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
    
          Image.asset(
            'assets/images/logo_background.png',
            fit: BoxFit.cover,
          ),

          Container(
            color: Color(0xFF4157FF).withOpacity(0.9), 
          ),

    
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_info.png',
                    width: 289,
                    height: 125,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 45),
                    child: Image.asset(
                      'assets/images/Vector.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}