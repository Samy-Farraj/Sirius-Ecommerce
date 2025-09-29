import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../src/components/svg_icon_widget.dart';
import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/pusher/pusher_manager.dart';
import '../../../../../src/routing/routes.dart';
import '../../../../../src/themes/app_icons.dart';
import '../../../../../src/themes/app_images.dart';
import '../../../../../src/utils/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  late final LocalStorage localStorage;

  void navigateToOnBoarding() {
    p(String k, String s) {
      if (kDebugMode) {
        print('navigateTo : $k  ||| $s');
      }
    }

    context.go(Routes.onBoarding);
  }

  void navigateTo() {
    p(String k, String s) {
      if (kDebugMode) {
        print('navigateTo : $k  ||| $s');
      }
    }

    p('token != null', (localStorage.token != null).toString());

    print("localStorage.tokenlocalStorage.token${localStorage.token}");
    if (localStorage.token != null) {
      context.go(Routes.dashboard);

      return;
    } else {
      context.go(Routes.login);
      return;
    }
  }

  late SharedPreferences prefs;
  Future<void> _initPreferencesAndNavigate() async {
    prefs = await SharedPreferences.getInstance();

    final seenOnboarding = prefs.getBool('isShowOnBoarding');

    if (seenOnboarding == true) {
      {
        p(String k, String s) {
          if (kDebugMode) {
            print('navigateTo : $k  ||| $s');
          }
        }

        p('token != null', (localStorage.token != null).toString());

        if (localStorage.token != null) {
          context.go(Routes.dashboard);
          return;
        } else {
          context.go(Routes.login);
          return;
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        //   _navigateToSplash();
      });
    } else {
      navigateToOnBoarding();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    localStorage = sl.get<LocalStorage>();
    Future.delayed(const Duration(seconds: 4), () {
      _initPreferencesAndNavigate();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _logoScale,
                      child: FadeTransition(
                        opacity: _logoOpacity,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 150.w,
                          height: 150.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                );
              }),
        ));
  }
}
