import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/features/auth/presentation/bloc/auth_bloc.dart';
import '../../app/features/auth/presentation/pages/login_screen.dart';
import '../../app/features/auth/presentation/pages/register/register_screen.dart';
import '../../app/features/auth/presentation/pages/verification_screen.dart';

import '../../app/features/settings/presentation/pages/language_screen.dart';
import '../../app/features/splash_screen/presentation/pages/OnboardingScreen.dart';
import '../../app/features/splash_screen/presentation/pages/spalsh_screen.dart';
import '../../app/features/splash_screen/presentation/pages/test_screen.dart';
import '../components/camera_card_scanner.dart';
import '../layout/presntation/page_viewer.dart';
import 'custom_navigation_observer.dart';
import 'fallback_screen.dart';
import 'routes.dart';

class AppRouter {
  final GoRouter goRouter;

  static late AppRouter _appRouter;

  static init() {
    _appRouter = AppRouter();
  }

  AppRouter() : goRouter = _getRouter;

  static get getRouter => _appRouter.goRouter;

  static final _rootKey = GlobalKey<NavigatorState>();

  // static final _shellKey = GlobalKey<NavigatorState>();

  static get _getRouter => GoRouter(
        navigatorKey: _rootKey,
        initialLocation: Routes.onBoarding,
        observers: [BotToastNavigatorObserver(), CustomNavigationObserver()],
        errorBuilder: (context, state) => const FallbackScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: Routes.onBoarding,
            builder: (BuildContext context, GoRouterState state) {
              return OnboardingScreen();
            },
          ),
          GoRoute(
            path: Routes.splashScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            },
          ),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return PageViewer(navigationShell);
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: Routes.home,
                    // parentNavigatorKey: _shellKey,
                    builder: (BuildContext context, GoRouterState state) {
                      return TestScreen();
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: Routes.tripsSection,
                    builder: (BuildContext context, GoRouterState state) {
                      return TestScreen();
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: Routes.account,
                    builder: (BuildContext context, GoRouterState state) {
                      return TestScreen();
                    },
                  ),
                ],
              )
            ],
          ),
          GoRoute(
            path: Routes.chooseLanguage,
            builder: (BuildContext context, GoRouterState state) {
              return const LanguageScreen();
            },
          ),
        ],
      );
}
