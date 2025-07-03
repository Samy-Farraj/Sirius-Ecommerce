import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/locale_keys.g.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../app_button.dart';
import 'custom_step.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({
    super.key,
    required this.pages,
    this.currentIndex = 0,
    this.onNextPressed,
    this.onPreviousPressed,
    this.appBar,
  });

  final PreferredSizeWidget? appBar;
  final List<Widget> pages;
  final int currentIndex;
  final void Function()? onNextPressed;
  final void Function()? onPreviousPressed;

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      persistentFooterButtons: [buildNextButton()],
      // resizeToAvoidBottomInset: true,
      // floatingActionButton: buildNextButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: REdgeInsets.all(8.0).copyWith(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 10.h,
                    child: Row(
                      children: List.generate(
                        widget.pages.length,
                        (index) =>
                            CustomStep(isActive: widget.currentIndex >= index),
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    LocaleKeys.step_of.tr(
                      args: [
                        '${widget.currentIndex + 1}',
                        '${widget.pages.length}',
                      ],
                    ),
                    style:
                        textTheme.bodySmall!.copyWith(color: AppColors.medium),
                  ),
                ],
              ),
            ),
            Padding(
              padding: REdgeInsets.all(16.0),
              child: widget.pages[widget.currentIndex],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildNextButton() {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.bottomCenter,
              child: AppButton(
                title: widget.currentIndex < widget.pages.length - 1
                    ? LocaleKeys.next.tr()
                    : LocaleKeys.confirm.tr(),
                onPressed: widget.onNextPressed,
              ),
            ),
          )
        ],
      ),
    );
  }
}
