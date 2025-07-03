import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../themes/app_colors.dart';
import 'icon_btn.dart';
import 'nav_button_model.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50.0.h,
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: NavigationBar(
        height: 40.h,
        selectedIndex: child.currentIndex,
        backgroundColor: AppColors.white,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (value) {
          print("THE VALUE IS ${value}");
          if (value == 1) {}
          print(
              "THE  child.currentIndex child.currentIndex IS ${child.currentIndex}");
          return child.goBranch(value,
              initialLocation: child.currentIndex == value);
        },
        destinations: List.generate(
          navButtons.length,
          (index) {
            return NavigationDestination(
              icon: IconBtn(
                btnIndex: index,
                currentIndex: child.currentIndex,
              ),
              label: '',
            );
          },
        ),
      ),
    );
  }
}
