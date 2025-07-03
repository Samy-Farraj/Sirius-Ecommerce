import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressLinearIndicator extends StatelessWidget {
  const CustomProgressLinearIndicator({super.key});

  @override
  Widget build(BuildContext context) {
      return Center(
      child: SpinKitThreeBounce(
        size: 12.sp,

      ),
    );
  }
}
