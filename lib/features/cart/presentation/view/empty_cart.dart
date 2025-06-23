import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:sizer/sizer.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 20.h),
            Image.asset(AssetsData.cart),
            SizedBox(height: 5.h),
            Text(
              ConstantText.whoops,
              style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 3.h),
            Text(
              ConstantText.yourCartEmpty,
              style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
