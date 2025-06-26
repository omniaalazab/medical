import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/home/presentation/view/home.dart';
import 'package:sizer/sizer.dart';

class SucessPayment extends StatelessWidget {
  const SucessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Image.asset(AssetsData.sucess),
              SizedBox(height: 5.h),
              Text(ConstantText.thankYou, style: Styles.textStyle24),
              SizedBox(
                width: 70.w,
                child: Center(
                  child: Text(
                    "Your Order will be delivered with invoice #9ds69hs. You can track the delivery in the order section.",
                    style: Styles.textStyle14,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              CustomElevatedButton(
                buttonText: ConstantText.continueOrder,
                onPressedFunction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
