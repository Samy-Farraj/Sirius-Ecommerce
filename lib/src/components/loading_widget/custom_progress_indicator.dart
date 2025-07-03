import 'package:capped_progress_indicator/capped_progress_indicator.dart';
import 'package:osm/src/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_icons.dart';
import '../svg_icon_widget.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgIcon(
          iconTitle: AppIcons.cscLogo,
          h: 24.h,
        ),
        SizedBox(
          width: 120.h,
          height: 120.h,
          child: CircularCappedProgressIndicator.adaptive(
            backgroundColor: AppColors.white,
            strokeCap: StrokeCap.round,
            strokeWidth: 9,
          ),
        ),
      ],
    );
  }
}
