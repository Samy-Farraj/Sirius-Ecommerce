import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osm/app/features/app/domain/entities/app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../src/themes/app_colors.dart';

class NewAppDialog extends StatelessWidget {
  final App app;
  final String currentVersionName;
  const NewAppDialog(
      {required this.app, required this.currentVersionName, super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text(
          'new_version_is_now_available'.tr(),
          style: TextStyle(
              color: AppColors.primary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "update_app".tr(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              '${"the_new_version".tr()} "${app.versionName}" ${"is_now_available".tr()}, ${"your_current_version".tr()} "$currentVersionName".',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
            !app.isRequired!
                ? SizedBox(
                    height: 8.h,
                  )
                : Container(),
            !app.isRequired!
                ? Text(
                    "would_like_to_update".tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                    ),
                  )
                : Container(),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              !app.isRequired!
                  ? TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('later'.tr(),
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    )
                  : Container(),
              !app.isRequired!
                  ? SizedBox(
                      width: 10.w,
                    )
                  : Container(),
              TextButton(
                onPressed: () => launchUrl(Uri.parse(app.description ??
                    "https://play.google.com/store/apps/details?id=com.damatag.ghayaex")),
                child: Text(
                  'update_now'.tr(),
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
