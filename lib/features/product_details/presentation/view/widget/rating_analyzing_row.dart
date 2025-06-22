import 'package:flutter/material.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:sizer/sizer.dart';

class RatingAnalyzingRow extends StatelessWidget {
  const RatingAnalyzingRow({
    super.key,
    required this.ratingNo,
    required this.valueLinearProgressIndicator,
    required this.ratePrecentage,
  });
  final String ratingNo;
  final double valueLinearProgressIndicator;
  final String ratePrecentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(ratingNo, style: Styles.textStyle14),
        Icon(Icons.star, color: ColorsHelper.amber, size: 20),
        SizedBox(
          width: 40.w,
          child: LinearProgressIndicator(
            value: valueLinearProgressIndicator,
            backgroundColor: Colors.grey[300], // unfilled portion color
            valueColor: AlwaysStoppedAnimation<Color>(
              ColorsHelper.blue,
            ), // filled portion color
            minHeight: 8, // thickness of the line
          ),
        ),
        Text(ratePrecentage, style: Styles.textStyle14),
      ],
    );
  }
}
