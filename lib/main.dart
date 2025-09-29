import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/di/app_initializer.dart';
import 'src/routing/router.dart';
import 'src/themes/app_theme.dart';

void main() async {
  await AppInitializer.init();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      path: 'assets/lang',
      child: SiriusEcommerce()));
}

class SiriusEcommerce extends StatelessWidget {
  const SiriusEcommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (
          BuildContext context,
          Widget? child,
        ) =>
            MaterialApp.router(
          title: 'SiriusEcommerce',
          theme: appTheme(context),
          builder: BotToastInit(),
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          routerConfig: AppRouter.getRouter,
          debugShowCheckedModeBanner: false,
        ),
      );
    });
  }
}
