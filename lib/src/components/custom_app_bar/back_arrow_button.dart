import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../themes/app_icons.dart';
import '../svg_icon_widget.dart';

class BackArrowButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;

  const BackArrowButton({
    super.key,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ??
          () {
            context.pop();
          },
      padding: EdgeInsets.zero,
      icon: SvgIcon(
        iconTitle: AppIcons.homeColored,
        color: color,
        w: 32.w,
        isDierctional: true,
      ),
    );
  }
}
