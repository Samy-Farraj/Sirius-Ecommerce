import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sirius/app/features/my_profile/presentation/widgets/setting_widgets/account_header.dart';
import 'package:sirius/app/features/my_profile/presentation/widgets/setting_widgets/language_popup.dart';
import 'package:sirius/app/features/my_profile/presentation/widgets/setting_widgets/restart_dialog.dart';
import 'package:sirius/app/features/my_profile/presentation/widgets/setting_widgets/settings_item.dart';
import 'package:sirius/src/components/custom_button.dart';

import '../../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../../src/components/custtom_button/GradientToggleSwitch.dart';
import '../../../../../../src/components/svg_icon_widget.dart';
import '../../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/routing/routes.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_sizes.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../../../src/utils/localization/app_languages.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   late final LocalStorage localStorage;
//
//   @override
//   void initState() {
//     super.initState();
//     localStorage = sl.get<LocalStorage>();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: CustomAppBar(
//         title: 'setting'.tr(),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildAccountHeader(context),
//               Text(
//                 "my_settings".tr(),
//                 style: textTheme.titleMedium,
//               ),
//               SizedBox(height: 20.h),
//               itemFromSection("edit_profile".tr(), () {
//                 context.push(Routes.editProfile);
//               }),
//               Divider(
//                 color: AppColors.medium,
//               ),
//               itemFromSection("company_pictures".tr(), () {
//                 context.push(Routes.companyPictures);
//               }),
//               Divider(
//                 color: AppColors.medium,
//               ),
//               itemFromSection("change_password".tr(), () {
//                 context.push(Routes.changePassword);
//               }),
//               Divider(
//                 color: AppColors.medium,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'light_mode'.tr(),
//                       style: textTheme.titleSmall!
//                           .copyWith(fontWeight: FontWeight.w500),
//                     ),
//                     GradientToggleSwitch(),
//                   ],
//                 ),
//               ),
//               Divider(
//                 color: AppColors.medium,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   _showLanguagePopup(context);
//                 },
//                 child: Container(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
//                   margin: EdgeInsets.symmetric(
//                     vertical: 10.h,
//                   ),
//                   decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "language".tr(),
//                         style: textTheme.titleSmall!
//                             .copyWith(fontWeight: FontWeight.w500),
//                       ),
//                       Row(
//                         children: [
//                           (context.locale.languageCode == "en")
//                               ? Text(
//                                   "ENGLISH".tr(),
//                                   style: textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14.sp,
//                                       color: AppColors.grey),
//                                 )
//                               : Text(
//                                   "ARABIC".tr(),
//                                   style: textTheme.titleSmall!.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14.sp,
//                                       color: AppColors.grey),
//                                 ),
//                           SizedBox(
//                             width: 13.w,
//                           ),
//                           SvgIcon(iconTitle: 'assets/icons/arrow.svg'),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAccountHeader(
//     BuildContext context,
//   ) {
//     late final LocalStorage localStorage;
//     localStorage = sl.get<LocalStorage>();
//     return GestureDetector(
//       onTap: () {
//         //    context.push(Routes.userProfile);
//       },
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(vertical: 16.h),
//         margin: EdgeInsets.symmetric(
//           vertical: 12.h,
//         ),
//         decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 62.w,
//                   height: 62.w,
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundImage: localStorage.appUser!.logo != null
//                         ? NetworkImage(localStorage.appUser!.logo.toString())
//                         : const AssetImage('assets/images/default_profile.png')
//                             as ImageProvider,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 15.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 250.w,
//                       child: Text(
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         localStorage.appUser!.name!,
//                         style: textTheme.titleSmall,
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     SizedBox(
//                       width: 250.w,
//                       child: Text(
//                         overflow: TextOverflow.ellipsis,
//                         localStorage.appUser!.email!,
//                         style: textTheme.labelSmall!
//                             .copyWith(fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showLanguagePopup(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: Stack(children: [
//               Positioned(
//                 top: 15.h,
//                 left: 0,
//                 child: GestureDetector(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: Container(
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.close, size: 20),
//                   ),
//                 ),
//               ),
//               Column(mainAxisSize: MainAxisSize.min, children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 20.0, bottom: 20),
//                   child: Text(
//                     'Choose Language',
//                     style: textTheme.titleMedium,
//                   ),
//                 ),
//                 Image.asset(
//                   'assets/images/logo.png',
//                   width: 65.w,
//                   height: 65.w,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Please Select your Preferred Language',
//                   style: textTheme.labelLarge!.copyWith(fontSize: 14.sp),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: CustomButton(
//                         isGradient: (context.locale.languageCode == 'ar')
//                             ? true
//                             : false,
//                         text: 'Arabic',
//                         radius: 50,
//                         color: AppColors.medium,
//                         textColor: (context.locale.languageCode == 'ar')
//                             ? Colors.white
//                             : AppColors.dark,
//                         onPressed: () {
//                           _changeLanguage(context, 'ar');
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 14.w,
//                     ),
//                     Expanded(
//                       child: CustomButton(
//                         isGradient: (context.locale.languageCode == 'en')
//                             ? true
//                             : false,
//                         text: 'English',
//                         radius: 50,
//                         color: AppColors.medium,
//                         textColor: (context.locale.languageCode == 'en')
//                             ? Colors.white
//                             : AppColors.dark,
//                         onPressed: () {
//                           _changeLanguage(context, 'en');
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ])
//             ]),
//           ),
//         );
//       },
//     );
//   }
//
//   void _changeLanguage(BuildContext context, String languageCode) {
//     context.setLocale(Locale(languageCode));
//     AppLanguages.setLocale(context, Locale(languageCode));
//     Navigator.of(context).pop();
//     _showRestartConfirmation(context);
//   }
//
//   void _showRestartConfirmation(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () async => false,
//           child: Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'restart_required'.tr(),
//                     style: textTheme.titleMedium,
//                   ),
//                   SizedBox(height: 20),
//                   Image.asset(
//                     'assets/images/logo.png',
//                     width: 65.w,
//                     height: 65.w,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'restart_app_message'.tr(),
//                     textAlign: TextAlign.center,
//                     style: textTheme.bodyMedium,
//                   ),
//                   SizedBox(height: 30),
//                   CustomButton(
//                     isGradient: true,
//                     text: 'restart_app'.tr(),
//                     onPressed: () {
//                       Restart.restartApp();
//                     },
//                     color: Colors.red,
//                     textColor: AppColors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget itemFromSection(String title, Function()? onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
//         margin: EdgeInsets.symmetric(
//           vertical: 10.h,
//         ),
//         decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style:
//                   textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
//             ),
//             SvgIcon(iconTitle: 'assets/icons/arrow.svg')
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../../src/components/custtom_button/GradientToggleSwitch.dart';
import '../../../../../../src/components/custom_button.dart';
import '../../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/routing/routes.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_sizes.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../../../src/utils/localization/app_languages.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final LocalStorage localStorage;

  @override
  void initState() {
    super.initState();
    localStorage = sl.get<LocalStorage>();
  }

  void _showLanguagePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LanguagePopup(
        onChangeLanguage: (code) => _changeLanguage(code),
      ),
    );
  }

  void _changeLanguage(String languageCode) {
    context.setLocale(Locale(languageCode));
    AppLanguages.setLocale(context, Locale(languageCode));
    Navigator.of(context).pop();
    _showRestartDialog();
  }

  void _showRestartDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => RestartDialog(
        onRestart: () => Restart.restartApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'setting'.tr()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountHeader(localStorage: localStorage),
              Text("my_settings".tr(), style: textTheme.titleMedium),
              SizedBox(height: 20.h),

              SettingsItem(
                title: "edit_profile".tr(),
                onTap: () => context.push(Routes.editProfile),
              ),
              Divider(color: AppColors.medium),

              SettingsItem(
                title: "company_pictures".tr(),
                onTap: () => context.push(Routes.companyPictures),
              ),
              Divider(color: AppColors.medium),

              SettingsItem(
                title: "change_password".tr(),
                onTap: () => context.push(Routes.changePassword),
              ),
              Divider(color: AppColors.medium),

              /// Dark/Light Mode
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('light_mode'.tr(),
                        style: textTheme.titleSmall!
                            .copyWith(fontWeight: FontWeight.w500)),
                    GradientToggleSwitch(),
                  ],
                ),
              ),
              Divider(color: AppColors.medium),

              /// Language Selector
              SettingsItem(
                title: "language".tr(),
                trailing: Row(
                  children: [
                    Text(
                      context.locale.languageCode == "en"
                          ? "ENGLISH".tr()
                          : "ARABIC".tr(),
                      style: textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(width: 13.w),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
                onTap: _showLanguagePopup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
