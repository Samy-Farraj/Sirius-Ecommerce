import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../themes/app_icons.dart';
import '../svg_icon_widget.dart';
import 'custom_progress_indicator.dart';

class CustomLoadingWidget extends StatelessWidget {
  final bool isLoading;

  final Widget child;

  const CustomLoadingWidget({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ?  Center(
      child:Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgIcon(
              iconTitle: AppIcons.carXBlack,
              h: 15.h,
            ),
            SizedBox(
              width: 70.h,
              height: 70.h,
              child:  CircularCappedProgressIndicator.adaptive(
                strokeCap: StrokeCap.round,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    )
        : child;
  }
}
