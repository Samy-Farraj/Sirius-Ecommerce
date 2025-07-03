import 'package:osm/src/themes/app_images.dart';
import 'package:flutter/material.dart';

class LoadingCar extends StatelessWidget {
  final double height;
  final double width;

  const LoadingCar({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.loading, // تأكد من تعديل المسار إذا كان مختلفًا
      height: height,
      width: width,

      fit: BoxFit.cover, // يمكنك تغييره حسب الحاجة
    );
  }
}
