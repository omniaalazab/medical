import 'package:flutter/material.dart';
import 'package:medical/core/utils/colors.dart';

class RadioButtonAddress extends StatelessWidget {
  const RadioButtonAddress({
    super.key,
    required this.index,
    required this.selectedValue,
    required this.onChanged,
  });

  final int index;
  final int selectedValue;
  final void Function(int?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Radio<int>(
      activeColor: ColorsHelper.blue,
      value: index,
      groupValue: selectedValue,
      onChanged: onChanged,
    );
  }
}
