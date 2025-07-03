import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import '../themes/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }

  static AppBar createAppBar({
    String title = '',
    bool isTextTitle = true,
    bool automaticallyImplyLeading = true,
    Widget? widgetTitle,
    List<Widget> actions = const [],
    bool centerTitle = true,
    Widget? leading,
  }) =>
      AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: centerTitle,
        elevation: 0.0,
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: actions,
        title: isTextTitle
            ? Text(
                title,
                style: textTheme.displaySmall!.copyWith(color: Colors.white),
              )
            : widgetTitle,
      );
}
