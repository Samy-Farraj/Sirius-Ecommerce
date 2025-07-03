// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../src/themes/app_icons.dart';
// import '../extensions/widget_extension.dart';
// import '../themes/app_colors.dart';
// import '../themes/app_theme.dart';
// import 'loading_widget/mini_loading_indicator.dart';
// import 'svg_icon_widget.dart';
//
// class CustomCounterButton extends StatelessWidget {
//   const CustomCounterButton({
//     Key? key,
//     required this.productId,
//     required this.onMinus,
//     required this.onPlus,
//     required this.counter,
//     this.height,
//     this.width,
//     this.hasIcon = true,
//   }) : super(key: key);
//
//   final String? productId;
//   final int counter;
//   final double? height;
//   final double? width;
//   final bool hasIcon;
//   final void Function() onMinus;
//   final void Function() onPlus;
//
//   @override
//   Widget build(BuildContext context) {
//     final state = context.read<CategoryBloc>().state;
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.r),
//           color: Colors.white,
//           border: Border.all(color: AppColors.lightest)),
//       child: FittedBox(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               iconSize: 18.sp,
//               icon: const Icon(Icons.remove),
//               onPressed: state.isCartActionLoading?[productId] == true
//                   ? null
//                   : onMinus,
//             ),
//             // 8.horizontalSpace,
//             Row(
//               children: [
//                 state.isCartActionLoading?[productId] == true
//                     ? const MiniLoadingIndicator()
//                     : Text(
//                         counter.toString(),
//                         style: textTheme.titleLarge!
//                             .copyWith(color: AppColors.darkest),
//                       ),
//                 if (hasIcon) ...[
//                   4.horizontalSpace,
//                   SvgIcon(
//                     iconTitle: (AppIcons.shoppingCartBold),
//                     w: 16.w,
//                   ),
//                 ],
//               ],
//             ),
//             // 8.horizontalSpace,
//             IconButton(
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               iconSize: 18.sp,
//               icon: const Icon(Icons.add),
//               onPressed:
//                   state.isCartActionLoading?[productId] == true ? null : onPlus,
//             ),
//           ],
//         ),
//       ),
//     ).size(h: height, w: width);
//   }
// }
