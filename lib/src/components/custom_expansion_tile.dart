// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_icons.dart';
import '../themes/app_theme.dart';
import 'svg_icon_widget.dart';

class CustomExpansionTile extends StatelessWidget {
  final String titleAddButton;
  final Widget title;
  final Widget contentExpansionElement;
  final void Function()? addOnTap;
  final void Function(bool expand)? event;
  final ExpansionTileController controller;
  final Widget? leading;

  const CustomExpansionTile({
    Key? key,
    required this.controller,
    required this.titleAddButton,
    required this.title,
    required this.contentExpansionElement,
    required this.addOnTap,
    this.event,
    this.leading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          controller: controller,
          leading: leading,
          onExpansionChanged: (expand) {
            if (event != null) {
              event!(expand);
            }
          },
          title: title,
          children: <Widget>[
            contentExpansionElement,
            GestureDetector(
              onTap: addOnTap,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Row(
                  children: [
                    SvgIcon(iconTitle: AppIcons.addSquare),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      titleAddButton.toString(),
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
