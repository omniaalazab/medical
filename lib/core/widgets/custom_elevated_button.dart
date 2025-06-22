import 'package:flutter/material.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    this.buttonIcon = const SizedBox(width: .5),
    required this.onPressedFunction,
    this.sideColor,
    this.alignButton = MainAxisAlignment.center,
    this.widthButton = double.infinity,
    this.textColor = Colors.white,
  });
  final String buttonText;

  final Color? sideColor;
  final Color textColor;

  final double widthButton;
  final Function()? onPressedFunction;
  final MainAxisAlignment alignButton;
  final Widget buttonIcon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(widthButton, 55),
        backgroundColor: ColorsHelper.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(
        buttonText,
        style: Styles.textStyle18.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
