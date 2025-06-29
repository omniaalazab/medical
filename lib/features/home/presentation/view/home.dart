import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/features/cart/presentation/view/cart.dart';
import 'package:medical/features/home/presentation/view/home_details.dart';
import 'package:medical/features/notification/data/repository/notification_repository.dart';
import 'package:medical/features/notification/presentation/view/notification_screen.dart';
import 'package:medical/features/profile/data/repos/profile_repo_implement.dart';
import 'package:medical/features/profile/presentation/cubit/cubit/profile_info_cubit.dart';
import 'package:medical/features/profile/presentation/views/profile_screen.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> imagePath = [
    AssetsData.home1,
    AssetsData.notifications1,
    AssetsData.shopping1,
    AssetsData.user,
  ];
  List<Map<String, dynamic>> screens = [
    {'screen': const HomeDetails()},
    {'screen': NotificationScreen()},
    {'screen': const CartView()},
    {
      'screen': BlocProvider(
        create: (context) => ProfileInfoCubit(
          ProfileRepoImplement(apiService: ApiService(dio: Dio())),
        ),
        child: ProfileScreen(),
      ),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        itemCount: imagePath.length,
        tabBuilder: (index, isActive) {
          return Image.asset(
            imagePath[index],
            width: 20.w,
            height: 25.h,
            color: isActive ? ColorsHelper.blue : ColorsHelper.lightpurple,
          );
        },

        activeIndex: selectedIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        splashColor: ColorsHelper.blue,
        backgroundColor: Colors.white,
        height: 8.h,
        leftCornerRadius: 31,
        rightCornerRadius: 31,
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: screens[selectedIndex]['screen'],
        ),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorsHelper.blue,
        child: const Icon(Icons.add_box_outlined, color: Colors.white),
      ),
    );
  }
}
