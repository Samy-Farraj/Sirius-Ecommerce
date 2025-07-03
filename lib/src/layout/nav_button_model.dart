import '../themes/app_icons.dart';
import '../themes/app_images.dart';

class NavButtonModel {
  final int id;
  final String imagePath;
  final String standardImagePath;

  NavButtonModel({
    required this.id,
    required this.imagePath,
    required this.standardImagePath,
  });
}

List<NavButtonModel> navButtons = [
  NavButtonModel(
    id: 0,
    imagePath: AppImages.home,
    standardImagePath: AppImages.home,
  ),
  NavButtonModel(
    id: 1,
    imagePath: AppImages.myTrips,
    standardImagePath: AppImages.myTrips,
  ),
  NavButtonModel(
    id: 2,
    imagePath: AppImages.setting,
    standardImagePath: AppImages.setting,
  ),
];
