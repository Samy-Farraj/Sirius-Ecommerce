import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/routing/routes.dart';
import '../pages/welcome_screen.dart';

class OnboardingBottomCard extends StatelessWidget {
  final String title;
  final String description;
  final int currentIndex;
  final int totalPages;
  final VoidCallback? onNext;
  final VoidCallback? onPrev;
  final VoidCallback? onGetStarted;
  final bool noMargin;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const OnboardingBottomCard({
    super.key,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.totalPages,
    this.onNext,
    this.onPrev,
    this.onGetStarted,
    this.noMargin = false,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      margin: noMargin
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.03),
      padding: EdgeInsets.fromLTRB(size.width * 0.06, size.height * 0.06,
          size.width * 0.06, size.height * 0.03),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                TextStyle(
                  fontSize: size.width * 0.055,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          SizedBox(height: size.height * 0.012),
          Text(
            description,
            style: descriptionStyle ??
                TextStyle(
                  fontSize: size.width * 0.038,
                  color: Colors.grey[700],
                ),
          ),
          SizedBox(height: size.height * 0.025),
          Row(
            children: [
              if (onPrev != null)
                TextButton(
                  onPressed: onPrev,
                  child: Text('Prev',
                      style: TextStyle(
                          color: Color(0xFFC4C4C4),
                          fontSize: 18.sp,
                          fontFamily: "Montserratmed")),
                ),
              const Spacer(),
              ...List.generate(
                totalPages,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 35 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: currentIndex == index
                        ? const LinearGradient(colors: [
                            Color(0xFFFA0AF2),
                            Color(0xFF0AFAE3),
                          ])
                        : null,
                    color: currentIndex == index ? null : Colors.grey[300],
                  ),
                ),
              ),
              const Spacer(),
              if (onNext != null)
                TextButton(
                  onPressed: onNext,
                  child: Text('Next',
                      style: TextStyle(
                          color: Color(0xFFFA0AF2),
                          fontFamily: "Montserratsemibold",
                          fontSize: 18.sp)),
                ),
              if (onGetStarted != null)
                GestureDetector(
                    onTap: () {
                      context.push(Routes.welcome);
                    },
                    child: Text('Get Started',
                        style: TextStyle(
                            color: Color(0xFFFA0AF2),
                            fontFamily: "Montserratsemibold",
                            fontSize: 18.sp))),
            ],
          ),
        ],
      ),
    );
  }
}
