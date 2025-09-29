import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/app/features/categories/domain/entities/category.dart';
import 'package:sirius/app/features/categories/presentation/widgets/products_in_category_widgets/product_grid.dart';
import 'package:sirius/app/features/categories/presentation/widgets/products_in_category_widgets/search_bar.dart';
import 'package:sirius/app/features/categories/presentation/widgets/products_in_category_widgets/sort_filter_section.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/di/services_locator.dart';
import 'package:sirius/src/themes/app_colors.dart';
import '../../../filters/presentation/bloc/filters_bloc.dart';
import '../../../product/domain/usecases/get_products_use_case.dart';
import '../../../product/presentation/bloc/prodcut_bloc.dart';
import '../bloc/categories_bloc.dart';

class ProductsInCategoryScreen extends StatefulWidget {
  final CategoriesBloc bloc;
  final String categoryId;
  final List<Category> categoriesChildren;

  const ProductsInCategoryScreen({
    required this.bloc,
    required this.categoryId,
    required this.categoriesChildren,
    super.key,
  });

  @override
  State<ProductsInCategoryScreen> createState() =>
      _ProductsInCategoryScreenState();
}

class _ProductsInCategoryScreenState extends State<ProductsInCategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  late final ProductBloc _productBloc;
  int _page = 1;
  final int _perPage = 5;
  bool _isLoading = false;
  bool _hasReachedEnd = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productBloc = sl.get<ProductBloc>();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  void _loadInitialData() {
    _productBloc.add(
      GetAllProductsEvent(
        params: GetProductParams(
          page: 1,
          perPage: _perPage,
          categoryId: [widget.categoryId],
        ),
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if (!_isLoading && !_hasReachedEnd) {
      setState(() => _isLoading = true);
      _productBloc.add(
        GetAllProductsEvent(
          params: GetProductParams(
            page: _page + 1,
            perPage: _perPage,
            categoryId: [widget.categoryId],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _productBloc),
        BlocProvider(
          create: (context) =>
              sl.get<FiltersBloc>()..add(GetFilterValueEvent()),
        ),
        BlocProvider.value(value: widget.bloc),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SearchBarWidget(
                  controller: searchController,
                  bloc: _productBloc,
                  categoryId: widget.categoryId,
                  categoriesChildren: widget.categoriesChildren,
                ),
              ),
              BlocBuilder<FiltersBloc, FiltersState>(
                builder: (context, state) {
                  return SortFilterSection(
                    categoryId: widget.categoryId,
                    productBloc: _productBloc,
                    filtersBloc: BlocProvider.of<FiltersBloc>(context),
                  );
                },
              ),
              Expanded(
                child: ProductGrid(
                  scrollController: _scrollController,
                  isLoading: _isLoading,
                  perPage: _perPage,
                  categoryId: widget.categoryId,
                  categoriesChildren: widget.categoriesChildren,
                  onPageUpdated: (newPage, reachedEnd) {
                    setState(() {
                      _page = newPage;
                      _hasReachedEnd = reachedEnd;
                      _isLoading = false;
                    });
                  },
                  onError: () => setState(() => _isLoading = false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
