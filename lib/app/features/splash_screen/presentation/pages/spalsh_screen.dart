import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final LocalStorage localStorage;

  @override
  void initState() {
    super.initState();
    localStorage = sl.get<LocalStorage>();
    Future.delayed(const Duration(seconds: 4), () {
      navigateTo();
    });
  }

  void navigateTo() {
    p(String k, String s) {
      if (kDebugMode) {
        print('navigateTo : $k  ||| $s');
      }
    }

    p('token != null', (localStorage.token != null).toString());
    // context.go(Routes.chooseLanguage);
    //PusherManager pusherManager = PusherManager();
    // 2️⃣ الاشتراك في قناة السائق
    String? driverId = localStorage.appUser?.id
        .toString(); // معرف السائق الذي تريد الاشتراك به
    // pusherManager.subscribeToDriverChannel(driverId ?? "");
    print("localStorage.tokenlocalStorage.token${localStorage.token}");
    if (localStorage.token != null) {
      if (localStorage.appUser?.isDriver == true) {
        context.go(Routes.driverMapScreen);
      } else {
        // context.go(Routes.home);
        context.go(Routes.home);
      }

      return;
    } else {
      context.go(Routes.login);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (localStorage.onBoardingSeen.isNullOrFalse) {}

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splash),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(),
      ),
    );
  }
}
