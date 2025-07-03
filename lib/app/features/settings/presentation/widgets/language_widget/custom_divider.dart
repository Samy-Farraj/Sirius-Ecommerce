import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 16.h),
      width: 396.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.5.w,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: const Color(0xFFECECEC),
          ),
        ),
      ),
    );
  }
}
