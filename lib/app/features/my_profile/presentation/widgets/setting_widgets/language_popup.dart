import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../../src/components/custom_button.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_theme.dart';

class LanguagePopup extends StatelessWidget {
  final Function(String) onChangeLanguage;

  const LanguagePopup({super.key, required this.onChangeLanguage});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose Language', style: textTheme.titleMedium),
            SizedBox(height: 20),
            Image.asset('assets/images/logo.png', width: 65.w, height: 65.w),
            SizedBox(height: 20),
            Text(
              'Please Select your Preferred Language',
              style: textTheme.labelLarge!.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    isGradient: context.locale.languageCode == 'ar',
                    text: 'Arabic',
                    radius: 50,
                    color: AppColors.medium,
                    textColor: context.locale.languageCode == 'ar'
                        ? Colors.white
                        : AppColors.dark,
                    onPressed: () => onChangeLanguage('ar'),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: CustomButton(
                    isGradient: context.locale.languageCode == 'en',
                    text: 'English',
                    radius: 50,
                    color: AppColors.medium,
                    textColor: context.locale.languageCode == 'en'
                        ? Colors.white
                        : AppColors.dark,
                    onPressed: () => onChangeLanguage('en'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
