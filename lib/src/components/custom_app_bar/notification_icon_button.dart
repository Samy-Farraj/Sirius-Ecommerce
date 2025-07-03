import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../routing/routes.dart';
import '../../themes/app_icons.dart';
import '../svg_icon_widget.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.w),
      child: IconButton(
        onPressed: () {
          // context.push(Routes.notifications);
        },
        padding: EdgeInsets.zero,
        icon: SvgIcon(
          iconTitle: AppIcons.notification,
          w: 24.sp,
        ),
      ),
    );
  }
}
