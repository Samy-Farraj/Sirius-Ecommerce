import 'package:flutter/material.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class TopLoginHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final String bgImagePath;
  final String starImagePath;

  const TopLoginHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onBack,
    this.bgImagePath = 'assets/images/top_bg.png',
    this.starImagePath = 'assets/images/star.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          bgImagePath,
          width: size.width,
          height: size.height * 0.27,
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 0,
          bottom: 30,
          child: Image.asset(
            starImagePath,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          right: context.locale.languageCode == "ar" ? 8 : null,
          left: context.locale.languageCode == "ar" ? null : 8,
          top: 8 + MediaQuery.of(context).padding.top,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
          ),
        ),
        Positioned(
          right: context.locale.languageCode == "ar" ? 18 : null,
          left: context.locale.languageCode == "ar" ? null : 18,
          bottom: size.height * 0.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.displaySmall!.copyWith(color: AppColors.white),
              ),
              SizedBox(height: 8),
              Text(
                " " + subtitle,
                style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
