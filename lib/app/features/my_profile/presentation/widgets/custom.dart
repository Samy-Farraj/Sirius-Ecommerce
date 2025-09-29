import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
import '../../../branches/domain/entities/branch.dart';
import '../../../city/domain/entities/city.dart';
import '../../../city/presentation/bloc/city_bloc.dart';

class CustomDropdown extends StatefulWidget {
  final Function(City?) onCitySelected;
  final CityBloc bloc;
  late bool? isEdit;
  final Branch? oldCity;

  CustomDropdown({
    super.key,
    this.isEdit = false,
    this.oldCity,
    required this.bloc,
    required this.onCitySelected,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  City? selectedCity;

  @override
  void initState() {
    super.initState();

    widget.bloc.add(GetAllCitiesEvent());
  }

  bool edited = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocConsumer<CityBloc, CityState>(
        listener: (context, state) {
          if (state is DoneGetCitiesState && edited == false) {
            if (widget.isEdit == true) {
              print('widget.oldCity!.cityId${widget.oldCity!}');
              selectedCity = state.cites.firstWhere(
                (city) => city.id == widget.oldCity!.cityId,
              );
              print('selectedCity.id ${selectedCity}');

              widget.bloc.cityId = selectedCity!.id.toString() ?? "0";
              widget.bloc.city = selectedCity!;
              widget.bloc.cityName = selectedCity!.name.toString() ?? "0"!;
              widget.isEdit = false;
              print('selectedCity.isEditisEdit ${widget.isEdit}');
            }
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "city".tr(),
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
                  child: DropdownButton<City>(
                    isExpanded: true,
                    value: selectedCity,
                    hint: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: SvgIcon(
                            iconTitle: 'assets/icons/location_grey.svg',
                          ),
                        ),
                        Text(
                          "choose_your_city".tr(),
                          style: textTheme.bodyMedium!
                              .copyWith(color: AppColors.grey),
                        ),
                      ],
                    ),
                    icon: SvgIcon(iconTitle: 'assets/icons/arrow_down.svg'),
                    items: _buildCityItems(state),
                    onChanged: (City? newValue) {
                      setState(() {
                        selectedCity = newValue;
                        if (newValue != null) {
                          edited = true;
                          print("NESVALUE ${widget.isEdit}");
                          print("NESVALUE ${newValue.name}");
                          widget.bloc.add(
                            SelectCityEvent(
                              cityId: newValue.id.toString(),
                              city: newValue,
                              cityName: newValue.name ?? "",
                            ),
                          );
                          widget.bloc.cityId = newValue.id.toString() ?? "0";
                        }
                      });
                      widget.onCitySelected(newValue);
                    },
                  ),
                ),
              ),
              if (state is LoadingGetCitiesState) _buildLoadingIndicator(),
              if (state is ErrorGetCitiesState) _buildErrorWidget(state),
            ],
          );
        },
      ),
    );
  }

  List<DropdownMenuItem<City>> _buildCityItems(CityState state) {
    if (state is DoneGetCitiesState) {
      return state.cites.map((City city) {
        return DropdownMenuItem<City>(
          value: city,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Text(
              (context.locale.languageCode == "en")
                  ? city.enName.toString()
                  : city.arName.toString() ?? '',
              style: textTheme.bodyMedium,
            ),
          ),
        );
      }).toList();
    }
    return [];
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        'loading Cities ....',
        style: textTheme.bodySmall,
      ),
    );
  }

  Widget _buildErrorWidget(ErrorGetCitiesState state) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        state.message,
        style: textTheme.bodyMedium!.copyWith(color: Colors.red),
      ),
    );
  }
}
