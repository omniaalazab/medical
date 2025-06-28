import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  const CategoryItem({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 20.w,
          height: 7.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(height: 3.h),
        Text(title, style: TextStyle(fontSize: 14.sp)),
      ],
    );
  }
}
