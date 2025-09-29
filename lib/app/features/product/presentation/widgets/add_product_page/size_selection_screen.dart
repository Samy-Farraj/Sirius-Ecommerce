import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sirius/app/features/size/domain/entities/size_entity.dart';
import '../../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../../src/components/custom_button.dart';
import '../../../../../../src/components/custom_text_field.dart';
import '../../../../../../src/components/error_screens/error_screen.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../../../src/utils/app_notifications.dart';
import '../../../../../../src/validation/required_validator.dart';
import '../../../../size/presentation/bloc/color_bloc.dart';
import '../../pages/add_product_step_tow_screen.dart';

class SizeSelectionScreen extends StatefulWidget {
  String categoryId;
  SizeBloc sizeBloc;

  @override
  _SizeSelectionScreenState createState() => _SizeSelectionScreenState();

  SizeSelectionScreen({
    required this.categoryId,
    required this.sizeBloc,
  });
}

class _SizeSelectionScreenState extends State<SizeSelectionScreen> {
  SizeEntity? _selectedSize;
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quantityController.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.sizeBloc,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'size_and_quantity'.tr(),
          actionIcon: SizedBox(),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'choose_quantity'.tr(),
                style: textTheme.labelLarge!.copyWith(fontSize: 14.sp),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: 352.w,
                child: TextFieldWithTitle(
                  title: "product_quantity".tr(),
                  widget: TextFormFieldWidget(
                    suffixIcon: SizedBox(
                      width: 70.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                var x = int.parse(
                                    _quantityController.text.toString());
                                if (x > 0) {
                                  x--;
                                  _quantityController.text = x.toString();
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.medium)),
                              child: Icon(
                                Icons.remove,
                                color: AppColors.darkMedium,
                                size: 14.sp,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                var x = int.parse(
                                    _quantityController.text.toString());
                                x++;
                                _quantityController.text = x.toString();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.medium)),
                              child: Icon(
                                Icons.add,
                                color: AppColors.darkMedium,
                                size: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    hintText: "product_quantity".tr(),
                    controller: _quantityController,
                    validator: RequiredValidator(),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'choose_size'.tr(),
                style: textTheme.labelLarge!.copyWith(fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              BlocBuilder<SizeBloc, SizeState>(
                builder: (context, state) {
                  if (state is LoadingSizesState) {
                    return SpinKitThreeInOut(
                      size: 15.sp,
                      color: AppColors.primary,
                    );
                  } else if (state is DoneSizesState) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.medium),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<SizeEntity>(
                          isExpanded: true,
                          value: _selectedSize,
                          hint: Text(
                            "e.g Xl",
                            style: textTheme.bodyMedium!
                                .copyWith(color: AppColors.grey),
                          ),
                          items: state.sizes!.map((size) {
                            return DropdownMenuItem<SizeEntity>(
                              value: size,
                              child: Text(
                                size.name ?? "size".tr(),
                                style: textTheme.labelMedium,
                              ),
                            );
                          }).toList(),
                          onChanged: (SizeEntity? newValue) {
                            setState(() {
                              _selectedSize = newValue;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ),
                      ),
                    );
                  } else if (state is ErrorSizesState) {
                    return ErrorScreen(
                      message: state.message,
                      onRetry: () {
                        BlocProvider.of<SizeBloc>(context).add(
                            GetAllSizesEvent(categoryId: widget.categoryId));
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: _selectedSize != null &&
                _quantityController.text.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 34.h),
                child: CustomButton(
                  onPressed: () {
                    if (_quantityController.text == "0") {
                      AppNotifications.showError(
                          message: 'please_add_quantity'.tr());
                    } else {
                      Navigator.pop(context, {
                        'sizeId': _selectedSize!.id!,
                        'quantity': int.parse(_quantityController.text),
                      });
                    }
                  },
                  text: 'add_size'.tr(),
                  color: Colors.red,
                  isGradient: true,
                  textColor: AppColors.white,
                ),
              )
            : null,
      ),
    );
  }

// Widget _buildSizeCard(SizeEntity size) {
//   final isSelected = _selectedSize?.id == size.id;
//
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         _selectedSize = size;
//       });
//     },
//     child: Container(
//       padding: EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white, // خلفية بيضاء
//         borderRadius: BorderRadius.circular(7),
//         border: Border.all(color: Colors.grey), // بوردر رمادي
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<SizeEntity>(
//           isExpanded: true,
//           value: _selectedSize,
//           hint: Text(
//             "اختر المقاس",
//             style: TextStyle(color: Colors.grey),
//           ),
//           items: availableSizes.map((size) {
//             return DropdownMenuItem<SizeEntity>(
//               value: size,
//               child: Text(size.name ?? "Size"),
//             );
//           }).toList(),
//           onChanged: (SizeEntity? newValue) {
//             setState(() {
//               _selectedSize = newValue;
//             });
//           },
//           icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
//         ),
//       ),
//     ),
//   );
// }
}
