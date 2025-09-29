// import 'dart:core';
//
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
//
// import '../../../../enums/cart_item_type.dart';
// import 'hive_boxes.dart';
// import 'hive_constants.dart';
//
// abstract class HiveInitializer {
//   static Future<void> initialize() async {
//     var documentsDirectory = await getApplicationDocumentsDirectory();
//     Hive.init(documentsDirectory.path);
//
//     bool isNotRegistered(int typeId) {
//       return !Hive.isAdapterRegistered(typeId);
//     }
//
//     if (isNotRegistered(HiveConstants.localCart)) {
//       // Hive.registerAdapter<LocalCart>(LocalCartAdapter());
//     }
//     if (isNotRegistered(HiveConstants.localCartItem)) {
//       // Hive.registerAdapter<LocalCartItem>(LocalCartItemAdapter());
//     }
//     if (isNotRegistered(HiveConstants.cartItemType)) {
//       Hive.registerAdapter<CartItemType>(CartItemTypeAdapter());
//     }
//   }
//
//   // static Future<Box<LocalCart>> initCartBox() async {
//   //   return Hive.openBox<LocalCart>(HiveBoxes.localCartBox);
//   // }
// }
