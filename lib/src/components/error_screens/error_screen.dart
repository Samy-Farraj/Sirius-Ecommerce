import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback? onRetry;
  final bool ableToRetry;
  final String message;
  const ErrorScreen(
      {this.onRetry,
      this.ableToRetry = true,
      required this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ableToRetry
            ? GestureDetector(
                onTap: onRetry,
                child: const Icon(
                  Icons.refresh,
                  size: 80,
                  color: Colors.red,
                ))
            : Container(),
        Text(
          message.tr(),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    ));
  }
}
