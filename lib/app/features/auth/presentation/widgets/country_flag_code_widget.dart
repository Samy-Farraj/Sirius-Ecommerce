import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src/extensions/iterable_extension.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';

class CountryFlagCodeWidget extends StatelessWidget {
  const CountryFlagCodeWidget(
      {Key? key, required this.flag, required this.dialCode})
      : super(key: key);

  final String flag;
  final String dialCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          flag,
          style: TextStyle(fontSize: 14.5.sp),
          overflow: TextOverflow.visible,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          dialCode,
          textDirection: TextDirection.ltr,
          style: textTheme.bodyLarge
              ?.copyWith(color: AppColors.black, fontSize: 14.sp),
        )
      ].addSpaces(width: 2.w).toList(),
    );
  }
}
