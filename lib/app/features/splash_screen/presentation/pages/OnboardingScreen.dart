import 'package:osm/src/components/svg_icon_widget.dart';
import 'package:osm/src/themes/app_colors.dart';
import 'package:osm/src/themes/app_icons.dart';
import 'package:osm/src/themes/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../src/routing/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final List<OnboardingModel> _pages = [
    OnboardingModel(
      title: 'Book_Ride_Anytime'.tr(),
      subtitle: 'your_destination_safely'.tr(),
      imagePosition: 0.50,
      iconTitle: AppIcons.first,
    ),
    OnboardingModel(
      title: 'Stay_Safe_with_Vehicle_Inspections'.tr(),
      subtitle: 'car_is_roadworthy_compliant'.tr(),
      imagePosition: 0.35,
      iconTitle: AppIcons.seconde,
    ),
    OnboardingModel(
      title: 'Keep_Your_Car_in_Top_Shape'.tr(),
      subtitle: 'We_fast_and_reliable'.tr(),
      imagePosition: 0.50,
      iconTitle: AppIcons.theard,
    ),
    OnboardingModel(
      title: 'We_Handle_the_Paperwork'.tr(),
      subtitle:
          'No_more_long_lines_confusion_manage_registration_renewals'.tr(),
      imagePosition: 0.30,
      iconTitle: AppIcons.four,
    ),
    OnboardingModel(
      title: 'Get_Covered_Confidence'.tr(),
      subtitle: 'Protect_your_vehicl_providers'.tr(),
      imagePosition: 0.30,
      iconTitle: AppIcons.five,
    ),
  ];

  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    // تهيئة الرسوم أولاً
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // استدعاء دالة غير متزامنة دون جعل initState async
    _initPreferencesAndNavigate();
  }

  Future<void> _initPreferencesAndNavigate() async {
    prefs = await SharedPreferences.getInstance();
    // هنا يمكنك فحص قيمة المفتاح.
    // ملاحظة: getBool يعيد null إذا المفتاح غير موجود، لذلك يمكنك مثلاً:
    final seenOnboarding = prefs.getBool('isShowOnBoarding');
    print(" seenOnboardingseenOnboardingseenOnboarding${seenOnboarding}");
    if (seenOnboarding == true) {
      // سبق وأن عرضت الشاشة؛ انتقل إلى الشاشة التالية
      // لاحظ أن التنقّل مبكرًا في initState قد يصادف أن context غير جاهز تمامًا
      // لذا يُفضل استعمال addPostFrameCallback لضمان تجهيز الواجهة:
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToSplash();
      });
    } else {
      // لم يُعرض بعد، ضع المفتاح إلى true
      await prefs.setBool('isShowOnBoarding', true);
      // ثم ستبقى في شاشة الـ onboarding حتى يكمل المستخدم، أو يمكنك التنقل بعدها حسب منطقك
    }
  }

  void _navigateToSplash() {
    context.push(Routes.splashScreen);
  }

  void _handleNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    } else {
      _navigateToSplash();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              // _animationController.reset();
              // _animationController.forward();
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                iconTitle: _pages[index].iconTitle,
                model: _pages[index],
                isLastPage: index == _pages.length - 1,
                onNext: _handleNext,
                currentPage: _currentPage,
                length: _pages.length,
              );
            },
          ),

          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _navigateToSplash,
              child: Text('skip'.tr(),
                  style: textTheme.labelLarge!
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ),

          // Positioned(
          //   bottom: 40,
          //   left: 0,
          //   right: 0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: List.generate(
          //       _pages.length,
          //       (index) => AnimatedContainer(
          //         duration: const Duration(milliseconds: 300),
          //         margin: const EdgeInsets.symmetric(horizontal: 4),
          //         width: _currentPage == index ? 20 : 8,
          //         height: 8,
          //         decoration: BoxDecoration(
          //           color: _currentPage == index
          //               ? Colors.blue
          //               : Colors.grey.withOpacity(0.5),
          //           borderRadius: BorderRadius.circular(4),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;
  final bool isLastPage;
  final VoidCallback onNext;
  final int currentPage;
  final String iconTitle;
  final int length;
  const OnboardingPage({
    super.key,
    required this.model,
    required this.isLastPage,
    required this.onNext,
    required this.iconTitle,
    required this.currentPage,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment(0, model.imagePosition),
              child: SvgIcon(iconTitle: iconTitle),
              // child: Image.asset(
              //   'assets/${model.title.toLowerCase().replaceAll(' ', '_')}.png',
              //   fit: BoxFit.contain,
              // ),
            ),
          ),
          const SizedBox(height: 40),
          Text(model.title, style: textTheme.labelLarge),
          const SizedBox(height: 20),
          Text(model.subtitle,
              textAlign: TextAlign.center,
              style: textTheme.labelLarge!.copyWith(
                  color: AppColors.grey, fontWeight: FontWeight.w600)),
          const SizedBox(height: 40),
          Row(
            children: [
              TextButton(
                onPressed: onNext,
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.blue,
                //   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                // ),
                child: Text(isLastPage ? 'get_started'.tr() : 'next'.tr(),
                    style: textTheme.labelLarge!
                        .copyWith(fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                width: 50.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.blue
                          : Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingModel {
  final String title;
  final String subtitle;
  final String iconTitle;
  final double imagePosition;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.iconTitle,
    required this.imagePosition,
  });
}
