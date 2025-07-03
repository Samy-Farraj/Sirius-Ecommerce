import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../generated/locale_keys.g.dart';
import '../themes/app_colors.dart';
import '../themes/app_theme.dart';
import 'custom_app_bar/custom_app_bar.dart';

class CameraCardScanner {
  const CameraCardScanner();

  // @override
  // State<CameraCardScanner> createState() => _CameraCardScannerState();
}

// class _CameraCardScannerState extends State<CameraCardScanner> {
//  // CardInfo? _cardInfo;
//   bool? isScan = false;
//   final ScannerWidgetController _controller = ScannerWidgetController();
//   @override
//   void initState() {
//     _controller.disableScanning();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MainAppBar(title: LocaleKeys.scan_card.tr()),
//       body: ScannerWidget(
//         controller: _controller,
//         overlayOrientation: CardOrientation.landscape,
//         cameraResolution: CameraResolution.max,
//         scannerDelay: 10000,
//         overlay: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                 width: 396.w,
//                 height: 150.h,
//                 decoration: BoxDecoration(
//                   color: AppColors.primary,
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _cardInfo != null
//                           ? '${LocaleKeys.card_number.tr()}: ${_divdeNumber(_cardInfo!.number)}'
//                           : '${LocaleKeys.card_number.tr()}: XXXX XXXX XXXX XXXX',
//                       style: textTheme.bodySmall!.copyWith(
//                         color: AppColors.white,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16.h,
//                     ),
//                     Text(
//                       _cardInfo == null || _cardInfo!.expiry == ''
//                           ? '${LocaleKeys.expiration_date.tr()}: XX/XX'
//                           : '${LocaleKeys.expiration_date.tr()}:${_cardInfo!.expiry}',
//                       style: textTheme.bodySmall!.copyWith(
//                         color: AppColors.white,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//                 child: Container(
//                   width: 0.8.sw,
//                   height: 0.2.sh,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.r),
//                     border: Border.all(color: AppColors.primary, width: 2.sp),
//                     color: Colors.transparent,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         overlayText: Padding(
//           padding: EdgeInsets.only(top: 500.h),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: InkWell(
//               onTap: () async {
//                 _controller.enableScanning();
//                 setState(() {
//                   isScan = true;
//                 });
//                 _controller.setCardListener((value) async {
//                   setState(() {
//                     _cardInfo = value;
//                     setState(() {
//                       isScan = false;
//                     });
//                     if (_cardInfo != null) {
//                       if (_cardInfo!.number != '' && _cardInfo!.expiry != '') {
//                         context.pop<CardInfo>(_cardInfo);
//                       }
//                     }
//                   });
//                 });
//               },
//               child: Container(
//                 width: 178.w,
//                 height: 60.h,
//                 decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(8.r),
//                     boxShadow: const [
//                       BoxShadow(color: AppColors.cardShadow, blurRadius: 2)
//                     ]),
//                 child: Center(
//                     child: isScan == false
//                         ? Text(
//                             LocaleKeys.scan.tr(),
//                             style: textTheme.bodySmall!.copyWith(
//                               fontSize: 16.sp,
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )
//                         : const CircularProgressIndicator(
//                             color: AppColors.primary,
//                           )),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _divdeNumber(String value) {
//     String result =
//         '${value.substring(0, 4)} ${value.substring(4, 8)} ${value.substring(8, 12)} ${value.substring(12, 16)}';
//     return result;
//   }
// }
