import '../themes/app_theme.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final TextStyle? style;
  const AppTextButton({
    Key? key,
    required this.text,
    this.style,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: style ?? textTheme.displaySmall,
      ),
    );
  }
}
