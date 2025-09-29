import 'package:easy_localization/easy_localization.dart';

import '../themes/app_icons.dart';
import '../themes/app_images.dart';

class NavButtonModel {
  final int id;
  final String title;
  final String imagePath;
  final String standardImagePath;

  NavButtonModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.standardImagePath,
  });
}

List<NavButtonModel> navButtons = [
  NavButtonModel(
    id: 0,
    imagePath: AppIcons.dashboardColored,
    standardImagePath: AppIcons.dashboard,
    title: 'dashboard'.tr(),
  ),
  NavButtonModel(
    id: 0,
    imagePath: AppIcons.offersColored,
    standardImagePath: AppIcons.offers,
    title: 'offers'.tr(),
  ),
  NavButtonModel(
    id: 0,
    imagePath: AppIcons.categoriesColored,
    standardImagePath: AppIcons.categories,
    title: 'categories'.tr(),
  ),
  NavButtonModel(
    id: 0,
    imagePath: AppIcons.profileColored,
    standardImagePath: AppIcons.profile,
    title: 'profile'.tr(),
  ),
];
