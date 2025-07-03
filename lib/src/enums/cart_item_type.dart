import 'package:hive/hive.dart';

import '../core/data_sources/local/hive/hive_constants.dart';

part 'cart_item_type.g.dart';

@HiveType(typeId: HiveConstants.cartItemType)
enum CartItemType {
  @HiveField(0)
  product,
  @HiveField(1)
  service,
  @HiveField(2)
  package,
  @HiveField(3)
  productAndService,
}
