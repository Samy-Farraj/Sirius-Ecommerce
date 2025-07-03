import 'package:osm/src/themes/app_colors.dart';
import 'package:osm/src/themes/app_theme.dart';
import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

class AppSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    required String desc,
    required SnackbarType type,
  }) {
    final colors = _getColors(type);
    final icon = _getIcon(type);

    final snackBar = SnackBar(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: colors.iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700, color: AppColors.dark),
                ),
                Text(
                  desc,
                  style: textTheme.bodySmall!.copyWith(),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.grey, size: 20),
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static ({Color backgroundColor, Color iconColor, Color textColor}) _getColors(
      SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return (
          backgroundColor: Colors.green.shade700,
          iconColor: Colors.green,
          textColor: Colors.white
        );
      case SnackbarType.error:
        return (
          backgroundColor: Colors.red.shade700,
          iconColor: Colors.red,
          textColor: Colors.white
        );
      case SnackbarType.info:
        return (
          backgroundColor: Colors.blue.shade700,
          iconColor: Colors.grey,
          textColor: Colors.white
        );
    }
  }

  static IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle;
      case SnackbarType.error:
        return Icons.error_outline;
      case SnackbarType.info:
        return Icons.info_outline;
    }
  }
}
