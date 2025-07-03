import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/locale_keys.g.dart';
import '../themes/app_theme.dart';
import 'app_button.dart';

class LoginAlertDialog extends StatelessWidget {
  const LoginAlertDialog({
    Key? key,
    required this.alertMessage,
    required this.onPressed,
  }) : super(key: key);
  final String alertMessage;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: REdgeInsets.all(16),
      elevation: 8,
      title: Center(
          child: Text(
        LocaleKeys.sign_in_first.tr(),
        style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
      )),
      content: Text(alertMessage),
      actions: [
        AppButton(
          title: LocaleKeys.login.tr(),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
