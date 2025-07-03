import 'package:osm/src/components/loading_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_progress_indicator.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;

  final Widget child;

  const LoadingWidget({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: LoadingCar(height: 175.w, width: 175.w),
          )
        : child;
  }
}
