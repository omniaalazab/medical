import 'package:flutter/material.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:sizer/sizer.dart';

class SaleRedTriangle extends StatelessWidget {
  const SaleRedTriangle({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TriangleClipper(),
      child: Container(
        width: 60,
        height: 60,
        color: color,
        child: Transform.rotate(
          angle: -45,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
            child: Text(
              text,
              style: Styles.textStyle10.copyWith(
                color: Colors.white,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveSize = 4.0;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - curveSize, 0);

    // Curve at the tip
    path.quadraticBezierTo(size.width, 0, size.width, curveSize);

    path.lineTo(curveSize, size.height);

    // Curve at the bottom-left corner
    path.quadraticBezierTo(0, size.height, 0, size.height - curveSize);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
