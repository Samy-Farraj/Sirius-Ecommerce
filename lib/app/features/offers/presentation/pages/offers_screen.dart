import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sirius/app/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:sirius/app/features/product/domain/entities/product.dart';
import 'package:sirius/src/components/custom_assets/custom_image_network.dart';
import 'package:sirius/src/components/error_screens/error_screen.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import 'package:sirius/src/routing/routes.dart';
import 'package:sirius/src/themes/app_sizes.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../product/domain/usecases/get_products_use_case.dart';
import '../../../product/presentation/bloc/prodcut_bloc.dart';
import '../widgets/product_offer_item.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final ScrollController _scrollController = ScrollController();
  late final ProductBloc _productBloc;
  int _page = 1;
  final int _perPage = 5;
  bool _isLoading = false;
  bool _hasReachedEnd = false;

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
        params: GetProductParams(page: 1, perPage: _perPage),
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
      setState(() {
        _isLoading = true;
      });

      _productBloc.add(
        GetAllProductsEvent(
          params: GetProductParams(
            page: _page + 1,
            perPage: _perPage,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();
  List<String> selectedProductIds = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _productBloc),
        BlocProvider(
          create: (context) => sl.get<OffersBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          showLogoImage: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(searchController, _productBloc),
                SizedBox(height: 16.h),
                _buildItemsTitle(),
                SizedBox(height: 16.h),
                Expanded(child: _buildProductsGrid()),
              ],
            ),
          ),
        ),
        floatingActionButton: selectedProductIds.isNotEmpty
            ? BlocBuilder<OffersBloc, OffersState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFA0AF2),
                            Color(0xFF0AFAE3),
                          ],
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white, size: 30.sp),
                        onPressed: () {
                          context.push(Routes.addNewOffer, extra: {
                            "productId": selectedProductIds,
                            "bloc": BlocProvider.of<OffersBloc>(context),
                            "productBloc": _productBloc,
                          });
                        },
                      ),
                    ),
                  );
                },
              )
            : null,
      ),
    );
  }

  Widget _buildProductsGrid() {
    return BlocConsumer<ProductBloc, ProductState>(
      buildWhen: (previous, current) {
        return current is LoadingProductsState ||
            current is DoneProductsState ||
            current is ErrorProductsState;
      },
      listener: (context, state) {
        print("THEEE STATA US IN OFFERS ${state}");
        if (state is DoneProductsState) {
          setState(() {
            print("c${_isLoading}");
            _isLoading = false;
            print("OFFFFFFFFFFFFFFFFFFF${_isLoading}");

            _page = state.product.currentPage ?? 1;
            _hasReachedEnd = _page >= (state.product.lastPage ?? 1);
          });
        } else if (state is ErrorProductsState) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      builder: (context, state) {
        print("THEEE STATA US IN OFFERS ${state}");

        if (state is DoneProductsState) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 13.w,
                    mainAxisSpacing: 16.h,
                    mainAxisExtent: 220.h + 84.h,
                  ),
                  itemCount: state.product.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = state.product!.data![index];

                    final isSelected =
                        selectedProductIds.contains(product.id.toString());

                    return ProductOfferItem(
                      data: product,
                      isSelected: isSelected,
                      textTheme: Theme.of(context).textTheme,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedProductIds.remove(product.id.toString());
                          } else {
                            selectedProductIds.add(product.id.toString());
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              if (_isLoading)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              if (_hasReachedEnd) SizedBox(),
            ],
          );
        } else if (state is ErrorProductsState) {
          return ErrorScreen(
            message: state.message,
            onRetry: () {
              BlocProvider.of<ProductBloc>(context).add(GetAllProductsEvent(
                  params: GetProductParams(page: 1, perPage: _perPage)));
            },
          );
        } else if (state is LoadingProductsState) {
          return Center(
            child: SpinKitThreeBounce(
              size: 18.sp,
              color: AppColors.primary,
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

Widget _buildSearchBar(
  TextEditingController controller,
  ProductBloc bloc,
) {
  return Container(
    height: 42.h,
    child: TextField(
      controller: controller,
      onChanged: (value) {
        bloc.add(
          GetAllProductsEvent(
            params: GetProductParams(
              page: 1,
              search: controller.text,
              perPage: 50,
            ),
          ),
        );
      },
      decoration: InputDecoration(
        prefixIcon: Container(
          margin: EdgeInsets.all(10.sp),
          child: SvgIcon(
            iconTitle: 'assets/icons/search.svg',
            w: 18.w,
            h: 18.w,
          ),
        ),
        hintText: 'search'.tr(),
        contentPadding: EdgeInsets.symmetric(vertical: 6.h),
        hintStyle: textTheme.labelMedium,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius.r),
          borderSide: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
    ),
  );
}

Widget _buildItemsTitle() {
  return Text('choose_your_product_make_Offer'.tr(),
      style: textTheme.titleSmall);
}
