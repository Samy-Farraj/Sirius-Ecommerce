// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../src/themes/app_theme.dart';
// import '../../app/features/category/presentation/widgets/product_price.dart';
// import '../../app/features/product_details/data/models/product_property.dart';
// import '../../app/features/product_details/presentation/widgets/product_properties_list.dart';
// import '../themes/app_colors.dart';
// import '../themes/app_sizes.dart';
// import 'star_rate_widget.dart';
//
// class ProductServicesWidget extends StatelessWidget {
//   final String title;
//   final double rate;
//   final double price;
//   final double oldPrice;
//   final List<ProductProperty> properties;
//
//   const ProductServicesWidget({
//     super.key,
//     required this.title,
//     required this.properties,
//     required this.rate,
//     required this.price,
//     required this.oldPrice,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: AppSizes.productServiceCardWidth,
//       // height: AppSizes.productServiceCardHeight,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         color: AppColors.primary,
//         child: Padding(
//           padding: REdgeInsets.all(16),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _title(),
//               16.verticalSpace,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _productProperties(),
//                   _endSide(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _title() {
//     return Text(
//       title,
//       maxLines: 1,
//       overflow: TextOverflow.ellipsis,
//       style: textTheme.titleLarge!.copyWith(color: AppColors.white),
//     );
//   }
//
//   Widget _productProperties() {
//     return Expanded(
//       child: ProductPropertiesList(
//         properties: properties,
//         inServiceCard: true,
//       ),
//     );
//   }
//
//   Widget _endSide() {
//     return Padding(
//       padding: EdgeInsetsDirectional.only(start: 8.w),
//       child: SizedBox(
//         width: 146.w,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const StarRateWidget(rate: 4.0),
//                 ProductPrice(
//                   price: price,
//                   priceBeforeDiscount: oldPrice,
//                   priceTextColor: AppColors.white,
//                   discountTextColor: AppColors.lightest,
//                 ),
//               ],
//             ),
//             // TODO: this widget needs product details model
//             // AddToCardButton(
//             //   productId: ,
//             //   backgroundColor: AppColors.white,
//             //   iconColor: AppColors.primary,
//             //   textColor: AppColors.primary,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
