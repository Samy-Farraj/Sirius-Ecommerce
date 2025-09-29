import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../../src/components/custom_button.dart';
import '../../../../../../src/components/error_screens/error_screen.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_sizes.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../color/domain/entities/my_color.dart';
import '../../../../color/presentation/bloc/color_bloc.dart';
import '../../pages/add_product_step_tow_screen.dart';

class ColorSelectionScreen extends StatefulWidget {
  ColorBloc colorBloc;

  @override
  _ColorSelectionScreenState createState() => _ColorSelectionScreenState();

  ColorSelectionScreen({
    required this.colorBloc,
  });
}

class _ColorSelectionScreenState extends State<ColorSelectionScreen> {
  MyColor? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.colorBloc,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "colors".tr(),
          actionIcon: SizedBox(),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 16.h),
              Text(
                'choose_color'.tr(),
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 16.h),
              BlocBuilder<ColorBloc, ColorState>(
                builder: (context, state) {
                  if (state is LoadingColorsState) {
                    return SpinKitThreeInOut(
                      size: 15.sp,
                      color: AppColors.primary,
                    );
                  } else if (state is DoneColorsState) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.colors!.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return _buildColorCard(state.colors![index]);
                        },
                      ),
                    );
                  } else if (state is ErrorColorsState) {
                    return ErrorScreen(
                      message: state.message,
                      onRetry: () {
                        BlocProvider.of<ColorBloc>(context)
                            .add(GetAllColorsEvent());
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
        bottomNavigationBar: _selectedColor != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 34.h),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context, _selectedColor);
                  },
                  text: 'add_color'.tr(),
                  color: Colors.red,
                  isGradient: true,
                  textColor: AppColors.white,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 18.sp,
          ),
          hintText: 'search'.tr(),
          hintStyle: textTheme.labelMedium,
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadius),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildColorCard(MyColor color) {
    print("hashcode${color.hashcode}");
    final isSelected = _selectedColor?.id == color.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppColors.medium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 16.w,
                  height: 16.w,
                  margin: EdgeInsets.only(right: 4.w, left: 4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(
                      int.parse(color.hashcode!.replaceFirst('#', '0xFF')),
                    ),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                ),
                Text(color.name ?? 'color'.tr(), style: textTheme.labelMedium),
              ],
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey[100],
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey[300]!,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
