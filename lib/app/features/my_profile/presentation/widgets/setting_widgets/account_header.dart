import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_sizes.dart';
import '../../../../../../src/themes/app_theme.dart';

class AccountHeader extends StatelessWidget {
  final LocalStorage localStorage;

  const AccountHeader({super.key, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 31,
            backgroundImage: localStorage.appUser?.logo != null
                ? NetworkImage(localStorage.appUser!.logo!)
                : const AssetImage('assets/images/default_profile.png')
                    as ImageProvider,
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250.w,
                child: Text(
                  localStorage.appUser?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 250.w,
                child: Text(
                  localStorage.appUser?.email ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
