import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../src/components/svg_icon_widget.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_sizes.dart';
import '../../../../../../src/themes/app_theme.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: textTheme.titleSmall!
                    .copyWith(fontWeight: FontWeight.w500)),
            trailing ?? const SvgIcon(iconTitle: 'assets/icons/arrow.svg'),
          ],
        ),
      ),
    );
  }
}
