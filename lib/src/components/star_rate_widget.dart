import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_theme.dart';

class StarRateWidget extends StatelessWidget {
  const StarRateWidget({
    Key? key,
    required this.rate,
    this.textColor,
  }) : super(key: key);

  final double rate;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      '⭐ ($rate)',
      style: textTheme.bodySmall!.copyWith(color: textColor ?? AppColors.white),
    );
  }
}
