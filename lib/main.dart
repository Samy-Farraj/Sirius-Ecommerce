import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:osm/app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:osm/src/core/data_sources/local/local_storage.dart';
import 'package:osm/src/di/services_locator.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/features/app/presntation/blocs/app/app_bloc.dart';
import 'generated/codegen_loader.g.dart';
import 'src/di/app_initializer.dart';
import 'src/routing/router.dart';
import 'src/themes/app_theme.dart';
import 'src/utils/localization/app_languages.dart';
import 'src/utils/localization/app_locales.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
  // await CacheHelper.init();
  // final userId = CacheHelper.getString('user-id', "");
  // if (userId.isNotEmpty) {
  //   try {
  //     final notificationsBody = CacheHelper.getString('$userId-notifications');
  //     List<NotificationModel> notifications = [];
  //     if (notificationsBody.isNotEmpty) {
  //       final jsonBody = jsonDecode(notificationsBody);
  //       if (jsonBody is List) {
  //         notifications =
  //             jsonBody.map((e) => NotificationModel.fromJson(e)).toList();
  //       }
  //     }
  // final notification = NotificationModel.fromMessage(message);
  // if (notifications.firstWhereOrNull((n) => n == notification) == null) {
  //   notifications.add(notification);
  //   final notificationsBodyJson = jsonEncode(notifications
  //       .map<Map<String, dynamic>>((notification) => notification.toJson())
  //       .toList());
  //   await CacheHelper.setString(
  //       '$userId-notifications', notificationsBodyJson);
  //   print("notification added");
  //   print(notification);
  // }
  // } catch (e) {
  //   print("error-add-background-notification");
  //   print(e);
  // }
//  }
}

Future<String?> getDeviceUniqueId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor;
  }

  return null;
}

Future<String?> getFCMToken() async {
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  print("THE TOKEN ${token}");
  return token;
}

void main() async {
  await AppInitializer.init();
  late final LocalStorage localStorage;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await PusherManager().init("token");
  localStorage = sl.get<LocalStorage>();
  print("FCM TOKEN IS ${getFCMToken().toString()}");
  // الحصول على التوكن بشكل صحيح
  final fcmToken = await getFCMToken();
  final uuid = await getDeviceUniqueId();

  print("FCM TOKEN IS $fcmToken");
  print("UUID IS $uuid");

  await localStorage.storeFcmToken(fcmToken ?? '');
  await localStorage.storeUUID(uuid!);

  print("Stored FCM: ${await localStorage.fcmToken!}");
  print("Stored UUID: ${await localStorage.uuid!}");
  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('locale') ?? 'ar';

  runApp(


      MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => sl<AuthBloc>(),
      ),

      BlocProvider(create: (context) => sl<AppBloc>()),
      //..add(GetAppEvent())
    ],
    child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/lang',
        fallbackLocale: const Locale('ar'),
        // startLocale: const Locale('ar'),
        startLocale: Locale(savedLocale),
        child: OsmApp()),
  ));
}

class OsmApp extends StatelessWidget {
  const OsmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      // context.setLocale(Locale(context.deviceLocale.languageCode ?? 'ar'));
      return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (
          BuildContext context,
          Widget? child,
        ) =>
            MaterialApp.router(
          title: 'CSC',
          theme: appTheme,
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
