import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/src/components/custom_assets/custom_image_network.dart';
import 'package:sirius/src/routing/routes.dart';
import '../../core/data_sources/local/local_storage.dart';
import '../../di/services_locator.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../svg_icon_widget.dart';
import 'back_arrow_button.dart';
import 'notification_icon_button.dart';

// class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String? title;
//   final bool isTextTitle;
//   final bool automaticallyImplyLeading;
//   final Widget? widgetTitle;
//   final bool withActions;
//   final List<Widget>? actions;
//   final bool? centerTitle;
//   final double? leadingWidth;
//   final Widget? leading;
//   final bool withLeading;
//   final void Function()? back;
//   final Color? backgroundColor;
//   final Color? textTitleColor;
//   final Color? leadingColor;
//   final double? elevation;
//
//   const MainAppBar({
//     Key? key,
//     this.isTextTitle = true,
//     this.textTitleColor,
//     this.title,
//     this.centerTitle = true,
//     this.widgetTitle,
//     this.automaticallyImplyLeading = true,
//     this.withLeading = true,
//     this.leadingColor,
//     this.leadingWidth,
//     this.leading,
//     this.back,
//     this.withActions = true,
//     this.actions,
//     this.elevation = 0.0,
//     this.backgroundColor,
//   }) : super(key: key);
//
//   // double _defaultAppBarHeight(context) {
//   //   if (Theme.of(context).platform == TargetPlatform.iOS) {
//   //     return kToolbarHeight - MediaQuery.of(context).padding.top;
//   //   }
//   //   return kToolbarHeight;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       // toolbarHeight: _defaultAppBarHeight(context),
//       backgroundColor: backgroundColor,
//       centerTitle: centerTitle,
//       elevation: elevation,
//       leadingWidth: leadingWidth,
//       leading: withLeading
//           ? leading ??
//               BackArrowButton(
//                 onPressed: back ??
//                     () {
//                       context.pop();
//                     },
//                 color: leadingColor,
//               )
//           : null,
//       automaticallyImplyLeading: automaticallyImplyLeading,
//       actions: withActions ? actions ?? [const NotificationIconButton()] : null,
//       title: isTextTitle
//           ? Text(
//               title ?? '',
//               style: textTheme.displaySmall!
//                   .copyWith(color: textTitleColor ?? AppColors.white),
//             )
//           : widgetTitle,
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final Widget? actionIcon;
  final VoidCallback? onActionPressed;
  bool? hideAction;
  bool? showLogoImage;
  CustomAppBar({
    Key? key,
    this.title,
    this.hideAction = false,
    this.showLogoImage = false,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcon,
    this.onActionPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    LocalStorage localStorage = sl.get<LocalStorage>();

    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: leadingIcon == null,
      title: title != null
          ? Text(title!, style: textTheme.titleLarge)
          : FutureBuilder<Widget>(
              future: buildLogoFromSvgAsset(
                height: 31.h,
                width: 46.w,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 24,
                    width: 80,
                    child: SizedBox(),
                  );
                }
                if (snapshot.hasError) {
                  return const SizedBox(
                    height: 24,
                    width: 80,
                    child: Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.white,
                    )),
                  );
                }
                return snapshot.data!;
              },
            ),
      leading: leadingIcon != null
          ? IconButton(
              icon: leadingIcon!,
              onPressed: onLeadingPressed,
            )
          : (showLogoImage == true)
              ? Container(
                  padding: (context.locale.languageCode == "en")
                      ? EdgeInsets.only(left: 20.w)
                      : EdgeInsets.only(right: 20.w),
                  width: 40.w,
                  height: 40.w,
                  decoration:
                      BoxDecoration(border: Border.all(color: AppColors.white)),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: localStorage.appUser!.logo != null
                        ? NetworkImage(localStorage.appUser!.logo.toString())
                        : const AssetImage('assets/images/default_profile.png')
                            as ImageProvider,
                  ),
                )
              : null,
      actions: (hideAction!)
          ? []
          : [
              (actionIcon != null)
                  ? IconButton(
                      icon: actionIcon!,
                      onPressed: onActionPressed,
                    )
                  : GestureDetector(
                      onTap: () {
                        context.push(Routes.notification);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 19.w),
                        child: SvgIcon(
                          w: 18.w,
                          h: 22.h,
                          iconTitle: 'assets/icons/notification.svg',
                        ),
                      ),
                    ),
            ],
    );
  }
}

Future<Widget> buildLogoFromSvgAsset({double? height, double? width}) async {
  final raw = await rootBundle.loadString('assets/icons/logo_app_bar.svg');
  final reg = RegExp(
      r'(?:xlink:href|href)\s*=\s*"(data:image\/[a-zA-Z]+;base64,([^"]+))"');
  final m = reg.firstMatch(raw);
  if (m != null) {
    final base64Data = m.group(2)!;
    final bytes = base64Decode(base64Data);
    return Image.memory(bytes,
        height: height, width: width, fit: BoxFit.contain);
  }
  final fixed = raw.replaceAll('xlink:href', 'href');
  return SvgPicture.string(fixed, height: height, width: width);
}
