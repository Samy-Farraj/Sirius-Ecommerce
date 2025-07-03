import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/extensions.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

ThemeData get appTheme => ThemeData(
      dialogTheme: dialogTheme,
      scaffoldBackgroundColor: AppColors.white,
      primarySwatch: AppColors.primary.toMaterialColor(),
      brightness: Brightness.light,
      fontFamily: "Cairo",
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.primary.toMaterialColor(),
      ),
      textTheme: textTheme,
      appBarTheme: appBarTheme,
      inputDecorationTheme: inputDecorationTheme,
    );

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
        fontSize: 38.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.dark,
      ),
      displaySmall: TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.dark,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.dark,
        fontFamily: "Cairo",
      ),
      titleMedium: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.dark,
        fontFamily: "Cairo",
      ),
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.dark,
        fontFamily: "Cairo",
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.dark,
        fontFamily: "Cairo",
      ),
      bodyLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
      ),
      bodyMedium: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.dark,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.grey,
      ),
    );

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
