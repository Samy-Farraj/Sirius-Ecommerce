// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';

class SkipTextButton extends StatelessWidget {
  final void Function()? onPressed;

  const SkipTextButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          LocaleKeys.skip.tr(),
          style: textTheme.labelLarge!.copyWith(
            color: AppColors.light,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
