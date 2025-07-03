import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/data_sources/local/hive/hive_initializer.dart';
import '../routing/router.dart';
import 'services_locator.dart';

abstract class AppInitializer {
  static init() async {
    // await Firebase.initializeApp();

    /// because binding should
    /// be initialized before calling runApp.
    WidgetsFlutterBinding.ensureInitialized();

    /// run on portrait mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /// loading .env file
    // await dotenv.load(fileName: '.env');

    ///initialize EasyLocalization
    await EasyLocalization.ensureInitialized();

    /// initialize routing
    AppRouter.init();

    /// hive initialize
    await HiveInitializer.initialize();

    /// dependencies injection
    await ServicesLocator.setup();

    /// hive initialize
    await HiveInitializer.initialize();
  }
}
