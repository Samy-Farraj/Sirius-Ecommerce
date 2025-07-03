import 'package:osm/src/themes/app_colors.dart';
import 'package:osm/src/themes/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBookingDialog extends StatelessWidget {
  final String title;
  final String description;
  final String actionButtonText;
  final VoidCallback? onActionPressed; // <-- أضفنا هذا البارامتر

  const CustomBookingDialog({
    super.key,
    required this.title,
    required this.description,
    required this.actionButtonText,
    this.onActionPressed, // <-- جعلناه اختياريًا
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: textTheme.labelLarge!.copyWith(color: AppColors.dark)),
          const SizedBox(height: 16),
          Text(description,
              style: textTheme.bodyLarge!.copyWith(color: AppColors.grey)),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'cancel'.tr(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (onActionPressed != null) {
                    onActionPressed!(); // <-- نستدعي الدالة هنا
                  }
                  Navigator.pop(context); // <-- نغلق الدايلوج بعد التنفيذ
                },
                child: Text(
                  actionButtonText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
