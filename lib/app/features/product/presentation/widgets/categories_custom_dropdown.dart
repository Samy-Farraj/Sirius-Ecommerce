import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:sirius/app/features/categories/presentation/bloc/categories_bloc.dart';

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
import '../bloc/prodcut_bloc.dart';

class CategoriesCustomDropdown extends StatefulWidget {
  final Function(Category?) onCategorySelected;
  ProductBloc bloc;
  List<Category> categoriesChildren = [];

  CategoriesCustomDropdown(
      {super.key,
      required this.bloc,
      required this.categoriesChildren,
      required this.onCategorySelected});

  @override
  State<CategoriesCustomDropdown> createState() =>
      _CategoriesCustomDropdownState();
}

class _CategoriesCustomDropdownState extends State<CategoriesCustomDropdown> {
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    // widget.bloc.add(GetAllCitiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: widget.bloc,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "product_category".tr(),
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
              child: DropdownButton<Category>(
                isExpanded: true,
                value: selectedCategory,
                hint: Row(
                  children: [
                    Text(
                      "choose_your_product_category".tr(),
                      style:
                          textTheme.bodyMedium!.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
                icon: SvgIcon(iconTitle: 'assets/icons/arrow_down.svg'),
                items: _buildCityItems(widget.categoriesChildren),
                onChanged: (Category? newValue) {
                  setState(() {
                    // widget.bloc.add(SelectCityEvent(
                    //     cityId: newValue!.id.toString(),
                    //     city: newValue,
                    //     cityName: newValue!.name.toString()));
                    selectedCategory = newValue;
                  });
                  widget.onCategorySelected(newValue);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<Category>> _buildCityItems(List<Category> state) {
    return state.map((Category city) {
      return DropdownMenuItem<Category>(
        value: city,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Text(
            city.name ?? '',
            style: textTheme.bodyMedium,
          ),
        ),
      );
    }).toList();
  }
}
