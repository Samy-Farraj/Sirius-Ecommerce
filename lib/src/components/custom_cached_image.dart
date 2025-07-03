import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../themes/app_colors.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    this.placeholderColor,
    required this.url,
    this.boxFit = BoxFit.contain,
    this.width,
    this.height,
    this.sizeIcon,
    // this.circleFallback = true,
    this.fallbackColor,
    this.imageColor,
    this.isSvg = false,
  });

  final String url;
  final Color? placeholderColor;
  final Color? imageColor;
  final BoxFit boxFit;
  final double? width;
  final double? height;
  final double? sizeIcon;
  // final bool circleFallback;
  final Color? fallbackColor;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    return isSvg
        ? SvgPicture.network(
            url,
            colorFilter: imageColor != null
                ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
                : null,
            fit: boxFit,
            width: width,
            height: height ?? 50.h,
            placeholderBuilder: (context) => Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: placeholderColor ?? AppColors.primary,
                size: height ?? 50.r,
              ),
            ),
          )
        : CachedNetworkImage(
            imageUrl: url,
            color: imageColor,
            fit: boxFit,
            width: width,
            height: height ?? 50.h,
            placeholder: (context, _) => Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: placeholderColor ?? AppColors.primary,
                size: height ?? 50.r,
              ),
            ),
            errorWidget: (context, _, __) => Icon(
              Icons.image,
              size: sizeIcon ?? 24.sp,
            ),
          );
  }
}
