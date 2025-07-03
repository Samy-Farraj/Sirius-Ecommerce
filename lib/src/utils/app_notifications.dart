import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class AppNotifications {
  static showSuccess({
    required String message,
    Color color = Colors.green,
  }) {
    print("Test showSuccess::${message}");
    BotToast.showText(
      duration: Duration(seconds: 2),
      text: message,
      contentColor: color,
      onlyOne: true,
    );
  }

  static showError({
    required String message,
    Color color = Colors.red,
  }) {
    print("Test showError::${message}");
    BotToast.showText(
      text: message,
      contentColor: color,
      onlyOne: true,
    );
  }

  static showMessage({
    required String message,
  }) {
    print("Test showMessage::${message}");
    BotToast.showCustomText(
      toastBuilder: (context) => Container(
        padding: const EdgeInsets.all(10),
        color: AppColors.primary,
        child: Text(
          message,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
      onlyOne: true,
    );
  }
}
