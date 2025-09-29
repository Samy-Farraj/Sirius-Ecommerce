import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/filters/presentation/widgets/filter_widgets/filter_content.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/themes/app_colors.dart';
import '../../../product/domain/usecases/get_products_use_case.dart';
import '../../../product/presentation/bloc/prodcut_bloc.dart';
import '../bloc/filters_bloc.dart';

class FilterScreen extends StatefulWidget {
  final FiltersBloc filtersBloc;
  final String categoryId;
  final ProductBloc productBloc;
  final int perPage;

  const FilterScreen({
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
  List<String> selectedGenderIds = [];
  List<String> selectedColorIds = [];
  List<String> selectedCategoryIds = [];
  List<String> selectedBrandIds = [];
  List<String> selectedSizeIds = [];
  double? minPrice;
  double? maxPrice;
  List<String> selectedDiscounts = [];

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
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: CustomAppBar(
              title: 'filter'.tr(),
              actionIcon: TextButton(
                onPressed: _clearAllFilters,
                child: Text(
                  'clear_all'.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            body: BlocBuilder<FiltersBloc, FiltersState>(
              builder: (context, state) {
                if (state is LoadingGetFilterProductState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorGetFilterProductState) {
                  return Center(child: Text(state.message));
                } else if (state is DoneGetFilterProductState) {
                  return FilterContent(
                    filter: state.filter,
                    selectedGenderIds: selectedGenderIds,
                    selectedColorIds: selectedColorIds,
                    selectedCategoryIds: selectedCategoryIds,
                    selectedBrandIds: selectedBrandIds,
                    selectedSizeIds: selectedSizeIds,
                    selectedDiscounts: selectedDiscounts,
                    onGenderChanged: (ids) =>
                        setState(() => selectedGenderIds = ids),
                    onColorChanged: (ids) =>
                        setState(() => selectedColorIds = ids),
                    onCategoryChanged: (ids) =>
                        setState(() => selectedCategoryIds = ids),
                    onBrandChanged: (ids) =>
                        setState(() => selectedBrandIds = ids),
                    onSizeChanged: (ids) =>
                        setState(() => selectedSizeIds = ids),
                    onPriceChanged: (min, max) =>
                        setState(() => {minPrice = min, maxPrice = max}),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            bottomNavigationBar: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(16.0),
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
    );
  }
}
