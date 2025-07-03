import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src/extensions/widget_extension.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/utils/countries.dart';
import '../bloc/auth_bloc.dart';
import 'country_flag_code_widget.dart';

class ChooseCountryWidget extends StatelessWidget {
  const ChooseCountryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read<AuthBloc>();
    return Container(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.5.h, horizontal: 5.w),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.dark),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.dark),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          iconColor: AppColors.dark,
          hintStyle: TextStyle(color: AppColors.darkest),
          labelStyle: TextStyle(color: AppColors.dark),
          counterStyle: TextStyle(color: AppColors.dark),
          suffixStyle: TextStyle(color: AppColors.dark),
        ),
        value: 'SY',
        focusColor: AppColors.dark,
        style: TextStyle(color: AppColors.dark),
        iconEnabledColor: AppColors.dark,
        iconDisabledColor: AppColors.dark,
        items: List.generate(
          Country.countries.length,
          (index) => DropdownMenuItem(
            value: Country.countries[index]['code']!,
            child: CountryFlagCodeWidget(
              dialCode: Country.countries[index]['dial_code']!,
              flag: Country.flagByIndex(index),
            ),
          ),
        ),
        onChanged: (Object? value) =>
            bloc.add(SelectCountryEvent(value.toString())),
      ).size(w: 80.w).pSymmetric(),
    );
    return SizedBox(
      width: 140.w,
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                iconColor: AppColors.dark,
                hintStyle: TextStyle(color: AppColors.darkest),
                labelStyle: TextStyle(color: AppColors.dark),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                counterStyle: TextStyle(color: AppColors.dark),
                suffixStyle: TextStyle(color: AppColors.dark),
              ),
              value: 'SY',
              focusColor: AppColors.dark,
              style: TextStyle(color: AppColors.dark),
              iconEnabledColor: AppColors.dark,
              iconDisabledColor: AppColors.dark,
              items: List.generate(
                Country.countries.length,
                (index) => DropdownMenuItem(
                  value: Country.countries[index]['code']!,
                  child: CountryFlagCodeWidget(
                    dialCode: Country.countries[index]['dial_code']!,
                    flag: Country.flagByIndex(index),
                  ),
                ),
              ),
              onChanged: (Object? value) =>
                  bloc.add(SelectCountryEvent(value.toString())),
            ).size(w: 95.w).pSymmetric(),
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            height: 45.h,
            width: 2.w,
            child: Container(
              color: AppColors.white,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
