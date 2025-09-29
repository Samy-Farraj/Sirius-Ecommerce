import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/components/custom_button.dart';

import '../../../../../src/di/services_locator.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../color/domain/entities/my_color.dart';
import '../../../product/data/models/PriceRangeFilterModel.dart';
import '../../../product/data/models/SubCategoryFilterModel.dart';
import '../../../product/domain/entities/company.dart';
import '../../../product/domain/usecases/get_products_use_case.dart';
import '../../../product/presentation/bloc/prodcut_bloc.dart';
import '../../../size/domain/entities/size_entity.dart';
import '../../domain/entities/FilterEntity.dart';
import '../bloc/filters_bloc.dart';

class FilterScreen extends StatefulWidget {
  FiltersBloc filtersBloc;
  final String categoryId;
  final ProductBloc productBloc;
  final int perPage;

  FilterScreen({
    Key? key,
    required this.categoryId,
    required this.filtersBloc,
    required this.productBloc,
    required this.perPage,
  }) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Selected filter values
  List<String> selectedGenderIds = [];
  List<String> selectedColorIds = [];
  List<String> selectedCategoryIds = [];
  List<String> selectedBrandIds = [];
  List<String> selectedSizeIds = [];
  double? minPrice;
  double? maxPrice;
  List<String> selectedDiscounts = [];

  @override
  void initState() {
    super.initState();
  }

  void _applyFilters() {
    widget.productBloc.add(
      GetAllProductsEvent(
        params: GetProductParams(
          page: 1,
          perPage: widget.perPage,
          categoryId: selectedCategoryIds.isNotEmpty
              ? selectedCategoryIds
              : [widget.categoryId],
          companies: selectedBrandIds,
          genders: selectedGenderIds,
          colors: selectedColorIds,
          sizes: selectedSizeIds,
          minPrice: minPrice?.toString(),
          maxPrice: maxPrice?.toString(),
        ),
      ),
    );
    Navigator.pop(context);
  }

  void _clearAllFilters() {
    setState(() {
      selectedGenderIds.clear();
      selectedColorIds.clear();
      selectedCategoryIds.clear();
      selectedBrandIds.clear();
      selectedSizeIds.clear();
      minPrice = null;
      maxPrice = null;
      selectedDiscounts.clear();
      selectedCategoryIds = [widget.categoryId];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.filtersBloc,
      child: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFF5F5F5),
            appBar: CustomAppBar(
              title: 'filter'.tr(),
              actionIcon: TextButton(
                onPressed: _clearAllFilters,
                child: Text(
                  'clear_all'.tr(),
                  style: textTheme.titleSmall,
                ),
              ),
            ),
            body: BlocBuilder<FiltersBloc, FiltersState>(
              builder: (context, state) {
                if (state is LoadingGetFilterProductState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ErrorGetFilterProductState) {
                  return Center(child: Text(state.message));
                } else if (state is DoneGetFilterProductState) {
                  return _buildFilterContent(state.filter);
                } else {
                  return SizedBox();
                }
              },
            ),
            bottomNavigationBar: Container(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomButton(
                  color: AppColors.red,
                  isGradient: true,
                  onPressed: _applyFilters,
                  text: 'apply'.tr(),
                  textColor: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterContent(FilterEntity filter) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildSectionTitle('gender'.tr(), () {
              _openMultiSelectionScreen<MyColor>(
                title: 'gender'.tr(),
                items: filter.colors ?? [],
                selectedIds: selectedColorIds,
                getId: (color) => color.id.toString(),
                getDisplayName: (color) => color.name ?? '',
                onSelectionChanged: (selectedIds) {
                  setState(() => selectedColorIds = selectedIds);
                },
              );
              ;
            }),
          ),
          Container(
            child: _buildHorizontalOptions<String>(
              options: filter.genders ?? [],
              selected: selectedGenderIds,
              getId: (category) => category.toString(),
              getDisplayName: (category) => category,
              onSelect: (id) {
                setState(() {
                  if (selectedGenderIds.contains(id)) {
                    selectedGenderIds.remove(id);
                  } else {
                    selectedGenderIds.add(id);
                  }
                });
              },
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildSectionTitle('colors'.tr(), () {
              _openMultiSelectionScreen<MyColor>(
                title: 'colors'.tr(),
                items: filter.colors ?? [],
                selectedIds: selectedColorIds,
                getId: (color) => color.id.toString(),
                getDisplayName: (color) => color.name ?? '',
                onSelectionChanged: (selectedIds) {
                  setState(() => selectedColorIds = selectedIds);
                },
              );
            }),
          ),
          _buildColorOptions(filter.colors ?? []),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildSectionTitle('category'.tr(), () {
              _openMultiSelectionScreen<SubCategoryFilterModel>(
                title: 'category'.tr(),
                items: filter.subCategories ?? [],
                selectedIds: selectedCategoryIds,
                getId: (category) => category.id.toString(),
                getDisplayName: (category) => category.name,
                onSelectionChanged: (selectedIds) {
                  setState(() => selectedCategoryIds = selectedIds);
                },
              );
            }),
          ),
          _buildHorizontalOptions(
            options: filter.subCategories ?? [],
            selected: selectedCategoryIds,
            getId: (category) => category.id.toString(),
            getDisplayName: (category) => category.name,
            onSelect: (id) {
              setState(() {
                if (selectedCategoryIds.contains(id)) {
                  selectedCategoryIds.remove(id);
                } else {
                  selectedCategoryIds.add(id);
                }
              });
            },
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildSectionTitle('brands'.tr(), () {
              _openMultiSelectionScreen<Company>(
                title: 'brands'.tr(),
                items: filter.companies ?? [],
                selectedIds: selectedBrandIds,
                getId: (company) => company.id.toString(),
                getDisplayName: (company) => company.name ?? '',
                onSelectionChanged: (selectedIds) {
                  setState(() => selectedBrandIds = selectedIds);
                },
              );
            }),
          ),
          _buildHorizontalOptions(
            options: filter.companies ?? [],
            selected: selectedBrandIds,
            getId: (company) => company.id.toString(),
            getDisplayName: (company) => company.name ?? '',
            onSelect: (id) {
              setState(() {
                if (selectedBrandIds.contains(id)) {
                  selectedBrandIds.remove(id);
                } else {
                  selectedBrandIds.add(id);
                }
              });
            },
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildSectionTitle('size'.tr(), () {
              _openMultiSelectionScreen<SizeEntity>(
                title: 'size'.tr(),
                items: filter.sizes ?? [],
                selectedIds: selectedSizeIds,
                getId: (size) => size.id.toString(),
                getDisplayName: (size) => size.name ?? '',
                onSelectionChanged: (selectedIds) {
                  setState(() => selectedSizeIds = selectedIds);
                },
              );
            }),
          ),
          _buildHorizontalOptions(
            options: filter.sizes ?? [],
            selected: selectedSizeIds,
            getId: (size) => size.id.toString(),
            getDisplayName: (size) => size.name ?? '',
            onSelect: (id) {
              setState(() {
                if (selectedSizeIds.contains(id)) {
                  selectedSizeIds.remove(id);
                } else {
                  selectedSizeIds.add(id);
                }
              });
            },
          ),
          SizedBox(height: 16.h),
          _buildPriceSection(filter.priceRange),
          SizedBox(height: 16.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20.w),
          //   child: _buildSectionTitle('Discount', null),
          // ),
          // _buildHorizontalOptions(
          //   options: ['1ESA', '2YNX', '3ESA', '4YNX'],
          //   selected: selectedDiscounts,
          //   onSelect: (value) {
          //     setState(() {
          //       if (selectedDiscounts.contains(value)) {
          //         selectedDiscounts.remove(value);
          //       } else {
          //         selectedDiscounts.add(value);
          //       }
          //     });
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback? onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleSmall,
        ),
        if (onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: Text(
              'view_all'.tr(),
              style: textTheme.labelMedium,
            ),
          ),
      ],
    );
  }

  Widget _buildHorizontalOptions<T>({
    required List<T> options,
    required List<String> selected,
    required String Function(T) getId,
    required String Function(T) getDisplayName,
    required Function(String) onSelect,
  }) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white),
      padding: EdgeInsets.only(right: 16.w, left: 16.w),
      height: 80.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          final id = getId(option);
          final displayName = getDisplayName(option);
          final isSelected = selected.contains(id);

          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: FilterChip(
              label: Text(
                displayName,
                style: textTheme.labelMedium,
              ),
              selected: isSelected,
              showCheckmark: false,
              onSelected: (isSelected) => onSelect(id),
              backgroundColor: Colors.white,
              selectedColor: Colors.white,
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.medium,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildColorOptions(List<MyColor> colors) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white),
      padding: EdgeInsets.only(right: 16.w, left: 16.w),
      height: 80.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          final isSelected = selectedColorIds.contains(color.id.toString());

          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  final colorId = color.id.toString();
                  if (selectedColorIds.contains(colorId)) {
                    selectedColorIds.remove(colorId);
                  } else {
                    selectedColorIds.add(colorId);
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 18.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.medium,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: 18.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(int.parse(
                            color.hashcode?.replaceFirst('#', '0xff') ??
                                '0xffffff')),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      color.name ?? '',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    SizedBox(width: 9.w),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceSection(PriceRangeFilterModel? priceRange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'price'.tr(),
            style: textTheme.titleSmall,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: 90.h,
          decoration: BoxDecoration(color: AppColors.white),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.lightest),
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.lightest),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'from_price'.tr(),
                    hintStyle:
                        textTheme.labelMedium!.copyWith(color: AppColors.grey),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    minPrice = double.tryParse(value);
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.lightest),
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.lightest),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'to_price'.tr(),
                    hintStyle:
                        textTheme.labelMedium!.copyWith(color: AppColors.grey),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    maxPrice = double.tryParse(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openMultiSelectionScreen<T>({
    required String title,
    required List<T> items,
    required List<String> selectedIds,
    required String Function(T) getId,
    required String Function(T) getDisplayName,
    required Function(List<String>) onSelectionChanged,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiSelectScreen<T>(
          title: title,
          items: items,
          selectedIds: selectedIds,
          getId: getId,
          getDisplayName: getDisplayName,
          onSelectionChanged: onSelectionChanged,
        ),
      ),
    );
  }
}

class MultiSelectScreen<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final List<String> selectedIds;
  final String Function(T) getId;
  final String Function(T) getDisplayName;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectScreen({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedIds,
    required this.getId,
    required this.getDisplayName,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<MultiSelectScreen> createState() => _MultiSelectScreenState<T>();
}

class _MultiSelectScreenState<T> extends State<MultiSelectScreen<T>> {
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        actionIcon: TextButton(
          onPressed: () {
            widget.onSelectionChanged(_selectedIds);
            Navigator.pop(context);
          },
          child: Text('apply'.tr()),
        ),
      ),
      body: ListView.separated(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final id = widget.getId(item);
          final displayName = widget.getDisplayName(item);
          final isSelected = _selectedIds.contains(id);

          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedIds.remove(id);
                } else {
                  _selectedIds.add(id);
                }
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
              margin: EdgeInsets.only(bottom: 0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayName,
                    style: textTheme.labelMedium,
                  ),
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.grey[100],
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color:
                            isSelected ? AppColors.primary : Colors.grey[300]!,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Divider(
              color: AppColors.medium,
            ),
          );
        },
      ),
    );
  }
}
