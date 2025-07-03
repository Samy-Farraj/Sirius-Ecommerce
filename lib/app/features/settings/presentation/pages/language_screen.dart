import 'package:osm/src/components/svg_icon_widget.dart';
import 'package:osm/src/routing/routes.dart';
import 'package:osm/src/themes/app_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../src/themes/app_colors.dart';
import '../../../../../../../src/themes/app_theme.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../../src/utils/localization/app_languages.dart';
import '../../../../../../src/utils/localization/app_locales.dart';
import '../../../../../src/themes/app_images.dart';
import '../widgets/language_widget/custom_divider.dart';
import '../widgets/language_widget/custom_language_button.dart';
import 'dart:ui' as ui;

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.loginImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                    sigmaX: 2.0,
                    sigmaY: 2.0), // قيم sigmaX و sigmaY تحدد قوة الضبابية
                child: Container(
                  color: AppColors.primaryShadow
                      .withOpacity(0.7), // اللون مع الشفافية
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 60.h),
                  child: Text(
                    LocaleKeys.choose_application_language.tr(),
                    style:
                        textTheme.titleLarge!.copyWith(color: AppColors.white),
                  ),
                ),
                CustomLanguageButton(
                  borderColor: AppColors.primary,
                  text: 'العربية',
                  color: AppColors.white,
                  textColor: AppColors.white,
                  onPressed: () {
                    AppLanguages.setLocale(context, arabicLocale);
                    context.go(Routes.login);
                  },
                ),
                SizedBox(
                  height: 32.h,
                ),
                // CustomLanguageButton(
                //   borderColor: AppColors.lightest,
                //   text: 'العربية - اللهجة المحلية',
                //   color: AppColors.white,
                //   textColor: AppColors.black,
                //   icon: SvgIcon(iconTitle: 'im_jordan_flag.svg'.imageAssetPath),
                //   iconDirection: ui.TextDirection.ltr,
                //   onPressed: () {
                //     AppLanguages.setLocale(context, arabicJordanLocale);
                //   },
                // ),
                // SizedBox(
                //   height: 32.h,
                // ),
                CustomLanguageButton(
                  borderColor: AppColors.light,
                  text: 'English',
                  color: AppColors.white,
                  textColor: AppColors.white,
                  onPressed: () {
                    AppLanguages.setLocale(context, englishLocale);
                    context.go(Routes.login);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: const CustomDivider(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
