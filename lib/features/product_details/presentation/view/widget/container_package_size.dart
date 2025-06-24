import 'package:flutter/material.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:sizer/sizer.dart';

class ContainerPackageSize extends StatelessWidget {
  const ContainerPackageSize({
    super.key,
    required this.noPallets,
    required this.price,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.black,
  });
  final String price;
  final String noPallets;
  final Color borderColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              price,
              style: Styles.textStyle16.copyWith(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              noPallets,
              style: Styles.textStyle12.copyWith(
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
