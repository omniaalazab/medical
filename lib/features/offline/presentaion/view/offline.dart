import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:sizer/sizer.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 20.h),
            Image.asset(AssetsData.noInternet),
            SizedBox(height: 2.h),
            Text(
              ConstantText.noInternetConnection,
              style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5.h),
            TextButton(
              onPressed: () {},
              child: Text(
                ConstantText.tryAgain,
                style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
