import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/locale_keys.g.dart';
import '../extensions/widget_extension.dart';
import '../themes/app_colors.dart';
import '../themes/app_icons.dart';
import '../themes/app_theme.dart';

class CustomAddToCartButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomAddToCartButton({
    Key? key,
    required this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: SvgPicture.asset(
        AppIcons.shoppingCartBold,
        color: iconColor ?? AppColors.white,
        width: 16.w,
        height: 16.w,
      ),
      label: Text(
        LocaleKeys.add_to_cart.tr(),
        style:
            textTheme.bodyLarge!.copyWith(color: textColor ?? AppColors.white),
      ),
      style: const ButtonStyle().copyWith(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
      ),
      onPressed: onPressed,
    ).size(h: 40.h, w: 146.w);
  }
}
