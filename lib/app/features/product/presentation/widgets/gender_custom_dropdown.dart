import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:sirius/app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:sirius/app/features/product/presentation/bloc/prodcut_bloc.dart';

import '../../../../../src/components/svg_icon_widget.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src/components/svg_icon_widget.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../city/domain/entities/city.dart';
import '../../../city/presentation/bloc/city_bloc.dart';

class GenderCustomDropdown extends StatefulWidget {
  final Function(String?) onGenderSelected;
  ProductBloc bloc;
  String? currentValue;
  GenderCustomDropdown(
      {super.key,
      required this.bloc,
      this.currentValue,
      required this.onGenderSelected});

  @override
  State<GenderCustomDropdown> createState() => _GenderCustomDropdownState();
}

class _GenderCustomDropdownState extends State<GenderCustomDropdown> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    if (widget.currentValue != null) {
      selectedGender = widget.currentValue;
    }
    // widget.bloc.add(GetAllCitiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "select_gender".tr(),
            style: textTheme.labelMedium,
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.medium),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedGender,
                hint: Row(
                  children: [
                    Text(
                      "choose_gender".tr(),
                      style:
                          textTheme.bodyMedium!.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
                icon: SvgIcon(iconTitle: 'assets/icons/arrow_down.svg'),
                items: _buildCityItems(['male', 'female', 'unisex']),
                onChanged: (String? newValue) {
                  setState(() {
                    // widget.bloc.add(SelectCityEvent(
                    //     cityId: newValue!.id.toString(),
                    //     city: newValue,
                    //     cityName: newValue!.name.toString()));
                    selectedGender = newValue;
                  });
                  widget.onGenderSelected(newValue); // إرجاع القيمة للوالد
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildCityItems(List<String> state) {
    return state.map((String city) {
      return DropdownMenuItem<String>(
        value: city,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Text(
            city ?? '',
            style: textTheme.bodyMedium,
          ),
        ),
      );
    }).toList();
  }
}
