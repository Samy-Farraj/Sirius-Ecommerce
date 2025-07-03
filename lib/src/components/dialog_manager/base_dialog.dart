import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/locale_keys.g.dart';
import '../../extensions/widget_extension.dart';
import '../app_button.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    required this.content,
    this.primaryButtonText,
    this.onPrimaryButtonPressed,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    this.isDismissible = true,
  });

  final Widget content;
  final String? primaryButtonText;
  final void Function()? onPrimaryButtonPressed;
  final String? secondaryButtonText;
  final void Function()? onSecondaryButtonPressed;
  final bool isDismissible;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return isDismissible;
      },
      child: AlertDialog(
        actions: [
          Row(
            children: [
              if (secondaryButtonText != null)
                Expanded(
                  child: AppButton.outlined(
                    title: secondaryButtonText!,
                    onPressed: () {
                      if (onPrimaryButtonPressed != null) {
                        onPrimaryButtonPressed!();
                      } else {
                        context.pop();
                      }
                    },
                  ),
                ),
              5.horizontalSpace,
              Expanded(
                child: AppButton(
                  title: primaryButtonText ?? LocaleKeys.confirm.tr(),
                  onPressed: () {
                    if (onPrimaryButtonPressed != null) {
                      onPrimaryButtonPressed!();
                    } else {
                      context.pop();
                    }
                  },
                ),
              ),
            ],
          ).size(h: 50.h)
        ],
        content: content,
      ),
    );
  }
}
