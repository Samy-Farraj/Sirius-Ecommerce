import 'package:flutter/material.dart';

import '../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../src/themes/app_colors.dart';

PreferredSizeWidget authAppBarWidget(
        {Key? key,
        required String title,
        required void Function()? leadingOnPressed}) =>
    MainAppBar(
      title: title,
      textTitleColor: AppColors.darkest,
      back: leadingOnPressed,
      withActions: false,
      leadingColor: AppColors.dark,
      backgroundColor: AppColors.white,
    );
