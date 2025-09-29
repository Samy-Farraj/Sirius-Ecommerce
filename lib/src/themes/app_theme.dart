import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/extensions.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

// ThemeData get appTheme => ThemeData(
//       dialogTheme: dialogTheme,
//       scaffoldBackgroundColor: AppColors.white,
//       primarySwatch: AppColors.primary.toMaterialColor(),
//       brightness: Brightness.light,
//       fontFamily: "Montserrat",
//       primaryColor: AppColors.primary,
//       colorScheme: ColorScheme.fromSwatch(
//         primarySwatch: AppColors.primary.toMaterialColor(),
//       ),
//       textTheme: textTheme,
//       appBarTheme: appBarTheme,
//       inputDecorationTheme: inputDecorationTheme,
//     );
bool isArabic = false;
String fontFamily = "Montserrat";
ThemeData appTheme(BuildContext context) {
  isArabic = context.locale.languageCode == 'ar';
  fontFamily = isArabic ? "Cairo" : "Montserrat";

  return ThemeData(
    dialogTheme: dialogTheme,
    scaffoldBackgroundColor: AppColors.white,
    primarySwatch: AppColors.primary.toMaterialColor(),
    brightness: Brightness.light,
    fontFamily: fontFamily,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.primary.toMaterialColor(),
    ),
    textTheme: textTheme,
    appBarTheme: appBarTheme,
    inputDecorationTheme: inputDecorationTheme,
  );
}

AppBarTheme get appBarTheme => AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: textTheme.displaySmall!,
    iconTheme: const IconThemeData(color: Colors.black));

DialogTheme get dialogTheme {
  return DialogTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.dialogRadius)));
}

TextTheme get textTheme => TextTheme(
      displayLarge: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
          fontFamily: fontFamily),
      displaySmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontFamily: fontFamily,
      ),

      //16.sp
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontFamily: fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        fontFamily: fontFamily,
      ),

      //12.sp
      labelLarge: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        fontFamily: fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
        fontFamily: fontFamily,
      ),
      labelSmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
          fontFamily: fontFamily),

      //10.sp
      bodyLarge: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.grey,
          fontFamily: fontFamily),
      bodyMedium: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontFamily: fontFamily),
      bodySmall: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
          fontFamily: fontFamily),
    );

///
// InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
//       labelStyle: textTheme.bodyLarge,
//       floatingLabelBehavior: FloatingLabelBehavior.never,
//       focusedBorder: OutlineInputBorder(
//         borderRadius:
//             const BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
//         borderSide:
//             BorderSide(width: AppSizes.borderWidth2, color: AppColors.focus),
//       ),
//       disabledBorder: OutlineInputBorder(
//         borderRadius:
//             const BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
//         borderSide:
//             BorderSide(width: AppSizes.borderWidth1, color: AppColors.disable),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius:
//             const BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
//         borderSide:
//             BorderSide(width: AppSizes.borderWidth2, color: AppColors.error),
//       ),
//       enabledBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
//         borderSide:
//             BorderSide(width: AppSizes.borderWidth1, color: AppColors.lightest),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius:
//             const BorderRadius.all(Radius.circular(AppSizes.borderRadius)),
//         borderSide: BorderSide(
//             width: AppSizes.borderWidth2, color: AppColors.focusError),
//       ),
//     );
InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
      labelStyle: textTheme.headlineMedium,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: AppSizes.borderWidth0, color: AppColors.primary),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: AppSizes.borderWidth0, color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: AppSizes.borderWidth0, color: AppColors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: AppSizes.borderWidth0, color: Colors.transparent),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(width: AppSizes.borderWidth0, color: AppColors.primary),
      ),
    );
