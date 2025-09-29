import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/auth/presentation/widgets/choose_country_widget.dart';
import 'package:sirius/src/themes/app_colors.dart';

class GradientToggleSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const GradientToggleSwitch({
    super.key,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<GradientToggleSwitch> createState() => _GradientToggleSwitchState();
}

class _GradientToggleSwitchState extends State<GradientToggleSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOn = !isOn;
        });
        widget.onChanged?.call(isOn);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 52.w,
        height: 27.h,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isOn
                ? [AppColors.primary, AppColors.secondary]
                : [Colors.grey.shade400, Colors.grey.shade300],
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 28.w,
            height: 28.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
