import 'package:flutter/material.dart';
import 'package:medical/core/utils/styles.dart';

class AddRemoveContainer extends StatelessWidget {
  const AddRemoveContainer({
    super.key,
    required this.onTap,
    required this.text,
    this.containerColor = Colors.transparent,
    this.borderColor = Colors.white,
    this.textColor = Colors.black,
  });
  final void Function()? onTap;
  final String text;
  final Color containerColor;
  final Color borderColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color: containerColor,
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Center(
          child: Text(
            text,
            style: Styles.textStyle18.copyWith(
              color: textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
