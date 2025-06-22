import 'package:flutter/material.dart';

import 'package:medical/core/utils/styles.dart';

class PaymentSummaryRow extends StatelessWidget {
  const PaymentSummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.textStyle = Styles.textStyle14,
  });
  final String title;
  final String value;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(title, style: textStyle),
          Spacer(),
          Text(value, style: textStyle),
        ],
      ),
    );
  }
}
