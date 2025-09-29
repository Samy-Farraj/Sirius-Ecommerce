import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../../src/components/custom_button.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_theme.dart';

class RestartDialog extends StatelessWidget {
  final VoidCallback onRestart;

  const RestartDialog({super.key, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('restart_required'.tr(), style: textTheme.titleMedium),
            SizedBox(height: 20),
            Image.asset('assets/images/logo.png', width: 65.w, height: 65.w),
            SizedBox(height: 20),
            Text(
              'restart_app_message'.tr(),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 30),
            CustomButton(
              isGradient: true,
              text: 'restart_app'.tr(),
              onPressed: onRestart,
              color: Colors.red,
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
