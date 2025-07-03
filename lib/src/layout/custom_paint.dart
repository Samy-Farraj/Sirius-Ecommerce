import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class ButtonNotch extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var dotPoint = Offset(size.width / 2, 2);
    var paint_1 = Paint()
      // ..color = Color(0x20252525)
      ..shader = const LinearGradient(
        colors: [Color(0x12252520), Colors.white],
        begin: Alignment.topCenter, // Start from the top
        end: Alignment.bottomCenter, // End at the bottom
      ).createShader(Rect.fromPoints(const Offset(0, 1),
          const Offset(0, 55))) // Apply to the entire height0
      ..style = PaintingStyle.fill;
    var paint_2 = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(7, 0.4, 12, 5);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2.4, size.width - 12, 5);
    path.quadraticBezierTo(size.width - 7.5, 0, size.width, 0);
    path.close();
    canvas.drawPath(path, paint_1);
    canvas.drawCircle(dotPoint, 3.sp, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
