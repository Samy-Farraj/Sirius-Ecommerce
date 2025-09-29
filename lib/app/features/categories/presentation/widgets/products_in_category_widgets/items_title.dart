import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sirius/src/themes/app_theme.dart';

class ItemsTitle extends StatelessWidget {
  final int? length;

  const ItemsTitle({this.length, super.key});

  @override
  Widget build(BuildContext context) {
    return Text('+${length ?? 0}${'items'.tr()}', style: textTheme.titleSmall);
  }
}
