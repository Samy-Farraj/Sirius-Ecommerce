import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sirius/src/themes/app_colors.dart';

class CustomImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? radius;
  final double? width;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool noCache;

  const CustomImageNetwork({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.radius,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.noCache = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String finalUrl = noCache
        ? "$imageUrl?nocache=${DateTime.now().millisecondsSinceEpoch}"
        : imageUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: finalUrl,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ??
            Center(
              child: SizedBox(
                height: height ?? 30,
                width: width ?? 30,
                child: SpinKitCubeGrid(
                  size: 12.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(radius ?? 0),
              ),
              alignment: Alignment.center,
              child: Image.asset('assets/images/error-image.png'),
            ),
      ),
    );
  }
}
