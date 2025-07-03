import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:osm/app/features/app/presntation/blocs/app/app_bloc.dart';
import 'package:osm/src/themes/app_colors.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../../app/features/app/presntation/dialogs/new_app_dialog.dart';

import '../../core/data_sources/local/local_storage.dart';
import '../../di/services_locator.dart';
import '../../routing/routes.dart';
import '../../themes/app_images.dart';
import '../custom_navigation_bar.dart';

class PageViewer extends StatefulWidget {
  PageViewer(this.child, {super.key});
  final StatefulNavigationShell child;
  @override
  State<PageViewer> createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  @override
  void initState() {
    super.initState();
    // _controller.addListener(_handleTabChange);
    // WidgetsBinding.instance.addPostFrameCallback((_) => _updateTabIndex());
  }

  // @override
  // void dispose() {
  //   _controller.removeListener(_handleTabChange);
  //   super.dispose();
  // }
  //
  // void _updateTabIndex() {
  //   final String location = GoRouterState.of(context).uri.toString();
  //   int targetIndex = 0;
  //
  //   if (location.endsWith(SubRoutes.tripsSection)) {
  //     targetIndex = 1;
  //   } else if (location.endsWith(SubRoutes.home)) {
  //     targetIndex = 2;
  //   }
  //
  //   if (_controller.index != targetIndex) {
  //     _controller.jumpToTab(targetIndex);
  //   }
  // }
  //
  // void _handleTabChange() {
  //   final String currentPath = _getPathForIndex(_controller.index);
  //   final String fullPath = '${Routes.pageViewer}/$currentPath';
  //
  //   if (GoRouterState.of(context).uri.toString() != fullPath) {
  //     context.go(fullPath);
  //   }
  // }
  //
  // String _getPathForIndex(int index) {
  //   switch (index) {
  //     case 0:
  //       return SubRoutes.home;
  //     case 1:
  //       return SubRoutes.tripsSection;
  //     case 2:
  //       return SubRoutes.home;
  //     default:
  //       return SubRoutes.home;
  //   }
  // }

  final PersistentTabController _controller = PersistentTabController();

  List<PersistentTabConfig> _tabs() => [
        // PersistentTabConfig(
        //   screen: MapScreen(),
        //   item: ItemConfig(
        //     icon: Image.asset(
        //       AppImages.home,
        //       height: 70.h,
        //       width: 70.w,
        //     ),
        //     title: "الرئيسية",
        //   ),
        // ),
        // PersistentTabConfig(
        //   screen: MyTripsScreen(),
        //   item: ItemConfig(
        //     icon: Image.asset(
        //       AppImages.myTrips,
        //       height: 70.h,
        //       width: 70.w,
        //     ),
        //     title: "رحلاتي",
        //   ),
        // ),
        // PersistentTabConfig(
        //   screen: AccountScreen(),
        //   item: ItemConfig(
        //     icon: Image.asset(
        //       AppImages.setting,
        //       height: 70.h,
        //       width: 70.w,
        //     ),
        //     title: "الحساب",
        //   ),
        // ),
      ];

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => _updateTabIndex());

    return Scaffold(
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state is LogInAgainInApp) {
            late final LocalStorage localStorage;

            localStorage = sl.get<LocalStorage>();
            localStorage.clearAppUser();
            context.go(Routes.login);
          }
          if (state is DoneGetAppState) {
            if (state.app != null) {
              showDialog(
                barrierDismissible: !state.app!.isRequired!,
                context: context,
                builder: (context) => NewAppDialog(
                    currentVersionName: state.currentVersionName,
                    app: state.app!),
              );
            }
          }
        },
        builder: (context, state) {
          return widget.child;
        },
      ),

      bottomNavigationBar: CustomNavigationBar(child: widget.child),
      // body: PersistentTabView(
      //   controller: _controller,
      //   tabs: _tabs(),
      //   navBarHeight: 66.h,
      //   navBarOverlap: NavBarOverlap.custom(overlap: 0.0),
      //   navBarBuilder: (navBarConfig) => Style4BottomNavBar(
      //     navBarConfig: navBarConfig,
      //   ),
      // ),
    );
  }
}
