import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiniLoadingIndicator extends StatelessWidget {
  const MiniLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 14.w,
      height: 14.w,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 2.sp,
      ),
    );
  }
}
