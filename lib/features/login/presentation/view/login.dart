import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/login/presentation/cubit/auth_cubit.dart';
import 'package:medical/features/login/presentation/cubit/auth_state.dart';

import 'verify_screen.dart';
=======
import 'package:medical/core/utils/assets.dart';
import 'package:medical/features/home/presentation/view/home.dart';
>>>>>>> 5ef7d698ad381f02022bdf93ade92a805021ebce

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
<<<<<<< HEAD
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyScreen(
                  phoneNumber: state.response.data?.phone ?? '',
                ),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_login.png',
                    width: 289,
                    height: 125,
                  ),
                  const SizedBox(height: 100),
                  const Text(
                    'Please Enter your Mobile Number\nto Login/Sign Up',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 35),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '+91 9265614292',
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Color(0xFF4157FF), width: 2),
                      ),
=======
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo_info (2).png",
                width: 289,
                height: 125,
              ),

              SizedBox(height: 100),

              Text(
                'Please Enter your Mobile Number\nto Login/Sign Up',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.grey),
              ),

              SizedBox(height: 35),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '+91 9265614292',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Color(0xFF4157FF), width: 2),
                  ),
                ),
              ),

              SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                    print('Phone: ${_phoneController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4157FF),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
>>>>>>> 5ef7d698ad381f02022bdf93ade92a805021ebce
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final phone = _phoneController.text;
                        BlocProvider.of<AuthCubit>(context).sendPhone(phone);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4157FF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: state is AuthLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'CONTINUE',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
