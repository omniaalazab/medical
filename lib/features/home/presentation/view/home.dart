import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medical/core/api/api_service.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/features/cart/presentation/view/cart.dart';
import 'package:medical/features/home/presentation/view/home_details.dart';
import 'package:medical/features/login/presentation/view/profile_screen.dart';
import 'package:medical/features/notification/data/repository/notification_repository.dart';
import 'package:medical/features/notification/presentation/view/notification_screen.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final ApiService apiService = ApiService();

  List<String> imagePath = [
    AssetsData.home1,
    AssetsData.notifications1,
    AssetsData.shopping1,
    AssetsData.user,
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> screens = [
      {'screen': const HomeDetails()},
      {
        'screen': NotificationScreen(
          repository: NotificationRepository(
            apiService,
            dio: apiService.dio,
          ),
          onBackPressed: () {
            setState(() {
              selectedIndex = 0;
            });
          },
        )
      },
      {'screen': const CartView()},
      {'screen': ProfileScreen()},
    ];

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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorsHelper.blue,
        child: const Icon(Icons.add_box_outlined, color: Colors.white),
      ),
    );
  }
}
