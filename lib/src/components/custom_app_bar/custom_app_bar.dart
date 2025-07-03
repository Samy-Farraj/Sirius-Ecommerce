import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import 'back_arrow_button.dart';
import 'notification_icon_button.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isTextTitle;
  final bool automaticallyImplyLeading;
  final Widget? widgetTitle;
  final bool withActions;
  final List<Widget>? actions;
  final bool? centerTitle;
  final double? leadingWidth;
  final Widget? leading;
  final bool withLeading;
  final void Function()? back;
  final Color? backgroundColor;
  final Color? textTitleColor;
  final Color? leadingColor;
  final double? elevation;

  const MainAppBar({
    Key? key,
    this.isTextTitle = true,
    this.textTitleColor,
    this.title,
    this.centerTitle = true,
    this.widgetTitle,
    this.automaticallyImplyLeading = true,
    this.withLeading = true,
    this.leadingColor,
    this.leadingWidth,
    this.leading,
    this.back,
    this.withActions = true,
    this.actions,
    this.elevation = 0.0,
    this.backgroundColor,
  }) : super(key: key);

  // double _defaultAppBarHeight(context) {
  //   if (Theme.of(context).platform == TargetPlatform.iOS) {
  //     return kToolbarHeight - MediaQuery.of(context).padding.top;
  //   }
  //   return kToolbarHeight;
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: _defaultAppBarHeight(context),
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      elevation: elevation,
      leadingWidth: leadingWidth,
      leading: withLeading
          ? leading ??
              BackArrowButton(
                onPressed: back ??
                    () {
                      context.pop();
                    },
                color: leadingColor,
              )
          : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: withActions ? actions ?? [const NotificationIconButton()] : null,
      title: isTextTitle
          ? Text(
              title ?? '',
              style: textTheme.displaySmall!
                  .copyWith(color: textTitleColor ?? AppColors.white),
            )
          : widgetTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
