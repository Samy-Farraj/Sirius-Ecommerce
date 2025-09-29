import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src/components/custom_assets/custom_image_network.dart';
import '../../../../../src/themes/app_colors.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const ProductImageSlider({Key? key, required this.imageUrls})
      : super(key: key);

  @override
  State<ProductImageSlider> createState() => ProductImageSliderState();
}

class ProductImageSliderState extends State<ProductImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    print("imagesssUrls${widget.imageUrls}");
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.imageUrls.length,
          onPageChanged: (index) {
            print("imagesssUrls${widget.imageUrls[index]}");
            setState(() => _currentPage = index);
          },
          itemBuilder: (context, index) {
            return CustomImageNetwork(
              fit: BoxFit.cover,
              imageUrl: widget.imageUrls[index],
              radius: 12.r,
            );
          },
        ),
        Positioned(
          bottom: 8.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.imageUrls.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: _currentPage == index ? 10.w : 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primary
                      : Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
