import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/filters/domain/entities/FilterEntity.dart';
import 'package:sirius/app/features/filters/presentation/widgets/filter_widgets/color_options.dart';
import 'package:sirius/app/features/filters/presentation/widgets/filter_widgets/horizontal_options.dart';
import 'package:sirius/app/features/filters/presentation/widgets/filter_widgets/multi_select_screen.dart';
import 'package:sirius/app/features/filters/presentation/widgets/filter_widgets/price_section.dart';
import 'package:sirius/app/features/filters/presentation/widgets/filter_widgets/section_title.dart';
import 'package:sirius/app/features/product/data/models/PriceRangeFilterModel.dart';
import 'package:sirius/app/features/product/data/models/SubCategoryFilterModel.dart';
import 'package:sirius/app/features/product/domain/entities/company.dart';
import 'package:sirius/app/features/size/domain/entities/size_entity.dart';

import 'package:easy_localization/easy_localization.dart';

class FilterContent extends StatelessWidget {
  final FilterEntity filter;
  final List<String> selectedGenderIds;
  final List<String> selectedColorIds;
  final List<String> selectedCategoryIds;
  final List<String> selectedBrandIds;
  final List<String> selectedSizeIds;
  final List<String> selectedDiscounts;
  final Function(List<String>) onGenderChanged;
  final Function(List<String>) onColorChanged;
  final Function(List<String>) onCategoryChanged;
  final Function(List<String>) onBrandChanged;
  final Function(List<String>) onSizeChanged;
  final Function(double?, double?) onPriceChanged;

  const FilterContent({
    super.key,
    required this.filter,
    required this.selectedGenderIds,
    required this.selectedColorIds,
    required this.selectedCategoryIds,
    required this.selectedBrandIds,
    required this.selectedSizeIds,
    required this.selectedDiscounts,
    required this.onGenderChanged,
    required this.onColorChanged,
    required this.onCategoryChanged,
    required this.onBrandChanged,
    required this.onSizeChanged,
    required this.onPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SectionTitle(
              title: 'gender'.tr(),
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiSelectScreen<String>(
                      title: 'gender'.tr(),
                      items: filter.genders ?? [],
                      selectedIds: selectedGenderIds,
                      getId: (g) => g,
                      getDisplayName: (g) => g,
                      onSelectionChanged: onGenderChanged,
                    ),
                  ),
                );
              },
            ),
          ),
          HorizontalOptions<String>(
            options: filter.genders ?? [],
            selected: selectedGenderIds,
            getId: (g) => g,
            getDisplayName: (g) => g,
            onSelect: (id) {
              final newList = List<String>.from(selectedGenderIds);
              if (newList.contains(id)) {
                newList.remove(id);
              } else {
                newList.add(id);
              }
              onGenderChanged(newList);
            },
          ),
          SizedBox(height: 16.h),

          /// Colors
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SectionTitle(
              title: 'colors'.tr(),
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiSelectScreen<MyColor>(
                      title: 'colors'.tr(),
                      items: filter.colors ?? [],
                      selectedIds: selectedColorIds,
                      getId: (c) => c.id.toString(),
                      getDisplayName: (c) => c.name ?? '',
                      onSelectionChanged: onColorChanged,
                    ),
                  ),
                );
              },
            ),
          ),
          ColorOptions(
            colors: filter.colors ?? [],
            selectedColorIds: selectedColorIds,
            onChanged: onColorChanged,
          ),
          SizedBox(height: 16.h),

          /// Category
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SectionTitle(
              title: 'category'.tr(),
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiSelectScreen<SubCategoryFilterModel>(
                      title: 'category'.tr(),
                      items: filter.subCategories ?? [],
                      selectedIds: selectedCategoryIds,
                      getId: (c) => c.id.toString(),
                      getDisplayName: (c) => c.name,
                      onSelectionChanged: onCategoryChanged,
                    ),
                  ),
                );
              },
            ),
          ),
          HorizontalOptions<SubCategoryFilterModel>(
            options: filter.subCategories ?? [],
            selected: selectedCategoryIds,
            getId: (c) => c.id.toString(),
            getDisplayName: (c) => c.name,
            onSelect: (id) {
              final newList = List<String>.from(selectedCategoryIds);
              if (newList.contains(id)) {
                newList.remove(id);
              } else {
                newList.add(id);
              }
              onCategoryChanged(newList);
            },
          ),
          SizedBox(height: 16.h),

          /// Brands
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SectionTitle(
              title: 'brands'.tr(),
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiSelectScreen<Company>(
                      title: 'brands'.tr(),
                      items: filter.companies ?? [],
                      selectedIds: selectedBrandIds,
                      getId: (c) => c.id.toString(),
                      getDisplayName: (c) => c.name ?? '',
                      onSelectionChanged: onBrandChanged,
                    ),
                  ),
                );
              },
            ),
          ),
          HorizontalOptions<Company>(
            options: filter.companies ?? [],
            selected: selectedBrandIds,
            getId: (c) => c.id.toString(),
            getDisplayName: (c) => c.name ?? '',
            onSelect: (id) {
              final newList = List<String>.from(selectedBrandIds);
              if (newList.contains(id)) {
                newList.remove(id);
              } else {
                newList.add(id);
              }
              onBrandChanged(newList);
            },
          ),
          SizedBox(height: 16.h),

          /// Size
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SectionTitle(
              title: 'size'.tr(),
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiSelectScreen<SizeEntity>(
                      title: 'size'.tr(),
                      items: filter.sizes ?? [],
                      selectedIds: selectedSizeIds,
                      getId: (s) => s.id.toString(),
                      getDisplayName: (s) => s.name ?? '',
                      onSelectionChanged: onSizeChanged,
                    ),
                  ),
                );
              },
            ),
          ),
          HorizontalOptions<SizeEntity>(
            options: filter.sizes ?? [],
            selected: selectedSizeIds,
            getId: (s) => s.id.toString(),
            getDisplayName: (s) => s.name ?? '',
            onSelect: (id) {
              final newList = List<String>.from(selectedSizeIds);
              if (newList.contains(id)) {
                newList.remove(id);
              } else {
                newList.add(id);
              }
              onSizeChanged(newList);
            },
          ),
          SizedBox(height: 16.h),

          PriceSection(
            priceRange: filter.priceRange,
            onChanged: onPriceChanged,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
