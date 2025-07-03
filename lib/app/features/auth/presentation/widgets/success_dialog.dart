import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src/components/app_button.dart';
import '../../../../../src/extensions/iterable_extension.dart';
import '../../../../../src/extensions/string_extension.dart';
import '../../../../../src/extensions/widget_extension.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key, required this.title, required this.image, required this.body, required this.buttonText, required this.onPressed}) : super(key: key);

  final String title;
  final String image;
  final String body;
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,style: textTheme.displaySmall?.copyWith(color: AppColors.darkest),),
          image.svg(h: 100.h,w: 100.w),
          Text(body,style: textTheme.titleLarge?.copyWith(color: AppColors.darkest),),
          AppButton(title: buttonText, onPressed: onPressed)
        ].addSpaces(height: 24.h).toList(),
      ).pSymmetric(h: 16,v: 24),
    );
  }
}
