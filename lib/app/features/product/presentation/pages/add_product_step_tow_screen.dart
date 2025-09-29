import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/app/features/branches/domain/entities/branch.dart' as br;

import 'package:sirius/app/features/branches/presentation/bloc/branches_bloc.dart';
import 'package:sirius/app/features/color/presentation/bloc/color_bloc.dart';
import 'package:sirius/app/features/product/presentation/bloc/prodcut_bloc.dart';
import 'package:sirius/app/features/size/presentation/bloc/color_bloc.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../src/components/custom_button.dart';
import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/utils/app_notifications.dart';
import '../../../color/domain/entities/my_color.dart';
import '../../../my_profile/presentation/bloc/my_profile_bloc.dart';
import '../../../size/domain/entities/size_entity.dart';
import '../../data/models/NewProductParameter.dart';
import '../../domain/usecases/get_products_use_case.dart';
import '../widgets/add_product_page/branch/branches_section.dart';
import '../widgets/add_product_page/branch_selection_screen.dart';
import '../widgets/add_product_page/color_selection_screen.dart';
import '../widgets/add_product_page/size_selection_screen.dart';

class AddProductStepTowScreen extends StatefulWidget {
  String name;
  String description;
  ProductBloc bloc;
  String gender;
  String isOnSale;
  String isReplaceable;
  String isRefundable;
  String points;
  String categories;
  String categoryChildId;
  String productPrice;
  List<File> productImages;
  bool isEdit;
  NewProductParameter? productToEdit;

  @override
  _AddProductStepTowScreenState createState() =>
      _AddProductStepTowScreenState();

  AddProductStepTowScreen({
    super.key,
    required this.name,
    required this.isEdit,
    this.productToEdit,
    required this.bloc,
    required this.categoryChildId,
    required this.description,
    required this.gender,
    required this.isOnSale,
    required this.isReplaceable,
    required this.isRefundable,
    required this.points,
    required this.productPrice,
    required this.productImages,
    required this.categories,
  });
}

class _AddProductStepTowScreenState extends State<AddProductStepTowScreen> {
  LocalStorage localStorage = sl.get<LocalStorage>();

  NewProductParameter product = NewProductParameter(
    companyId: 0,
    name: '',
    description: '',
    gender: 'Men',
    isOnSale: 0,
    isReplaceable: 0,
    isRefundable: 0,
    points: 0,
    categories: [],
    branches: [],
    images: [],
    price: 0.0,
  );

  @override
  void initState() {
    print("widget.categoryChildId${widget.categoryChildId}");
    // TODO: implement initState
    super.initState();
    //  log("THE FILE IMAGE IS ${widget.productImages.path}");
    if (widget.isEdit == true) {
      product = NewProductParameter(
        productId: widget.productToEdit!.productId,
        companyId: localStorage.appUser!.id!,
        name: widget.name,
        description: widget.description,
        gender: widget.gender,
        isOnSale: int.parse(widget.isOnSale.toString()),
        isReplaceable: int.parse(widget.isReplaceable.toString()),
        isRefundable: int.parse(widget.isRefundable.toString()),
        points: int.parse(widget.points.toString()),
        categories: (widget.categoryChildId == "")
            ? [int.parse(widget.categories)]
            : [int.parse(widget.categoryChildId), int.parse(widget.categories)],
        branches: widget.productToEdit?.branches ?? [],
        images: widget.productImages,
        price: double.parse(widget.productPrice.toString()),
      );
    } else {
      product = NewProductParameter(
        companyId: localStorage.appUser!.id!,
        name: widget.name,
        description: widget.description,
        gender: widget.gender,
        isOnSale: int.parse(widget.isOnSale.toString()),
        isReplaceable: int.parse(widget.isReplaceable.toString()),
        isRefundable: int.parse(widget.isRefundable.toString()),
        points: int.parse(widget.points.toString()),
        categories: (widget.categoryChildId == "")
            ? [int.parse(widget.categories)]
            : [int.parse(widget.categoryChildId), int.parse(widget.categories)],
        branches: [],
        images: widget.productImages,
        price: double.parse(widget.productPrice.toString()),
      );
    }

    print('product  ${product.toJson()}');
  }

  late BuildContext myProfileContext;
  late BuildContext myColorContext;
  late BuildContext mySizeContext;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: widget.bloc,
        ),
        BlocProvider(
          create: (context) =>
              sl.get<MyProfileBloc>()..add(GetProfileInfoEvent()),
        ),
        BlocProvider(
          create: (context) => sl.get<SizeBloc>()
            ..add(GetAllSizesEvent(categoryId: widget.categoryChildId)),
        ),
        BlocProvider(
          create: (context) => sl.get<ColorBloc>()..add(GetAllColorsEvent()),
        ),
      ],
      child: Scaffold(
          appBar: CustomAppBar(),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 30.h),
            child: BlocBuilder<MyProfileBloc, MyProfileState>(
              builder: (profileContext, state) {
                myProfileContext = profileContext;
                return BlocBuilder<SizeBloc, SizeState>(
                  builder: (context, state) {
                    mySizeContext = context;
                    return BlocBuilder<ColorBloc, ColorState>(
                      builder: (contextColor, state) {
                        myColorContext = contextColor;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BranchesSection(
                              product: product,
                              onAddBranch: _navigateToBranchSelection,
                              onRemoveBranch: _removeBranch,
                              onAddColor: _navigateToColorSelection,
                              onRemoveColor: _removeColor,
                              onAddSize: _navigateToSizeSelection,
                              onRemoveSize: _removeSize,
                              colorBloc: BlocProvider.of<ColorBloc>(context),
                              sizeBloc: BlocProvider.of<SizeBloc>(context),
                              profileBloc:
                                  BlocProvider.of<MyProfileBloc>(context),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is DoneCreateNewProductState) {
                  widget.bloc.add(
                    GetAllProductsEvent(
                      params: GetProductParams(
                          page: 1,
                          perPage: 10,
                          categoryId: [widget.categories]),
                    ),
                  );
                  context.pop();
                  context.pop();
                }
              },
              //https://sirius.taskati.net/api/company/products?page=1&per_page=5&sub_categories%5B%5D=5&companies%5B%5D=3&platform=android
              //https://sirius.taskati.net/api/company/products?page=1&per_page=10&sub_categories%5B%5D=5&companies%5B%5D=3&platform=android
              builder: (context, state) {
                return CustomButton(
                    text: (widget.isEdit == true)
                        ? "edit_product".tr()
                        : "add_product".tr(),
                    color: Colors.red,
                    isGradient: true,
                    isLoading: state is LoadingCreateNewProductState,
                    textColor: AppColors.white,
                    onPressed: () {
                      if (product.branches.isEmpty) {
                        AppNotifications.showError(
                            message: 'please_add_branch'.tr());
                      } else {
                        if (widget.isEdit == true) {
                          widget.bloc.add(EditProductEvent(parameter: product));
                          print("TH FINAL RESOLT ${product.toJson()}");
                        } else {
                          widget.bloc
                              .add(CreateNewProductEvent(parameter: product));
                          print("TH FINAL RESOLT ${product.toJson()}");
                        }
                      }
                    });
              },
            ),
          )),
    );
  }

  void _navigateToBranchSelection() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (contextNew) => BranchSelectionScreen(
                myProfileBloc: BlocProvider.of<MyProfileBloc>(myProfileContext),
              )),
    );
    print("THE RESPULT${result.toString()}");
    if (result != null && result is br.Branch) {
      // After selecting branch, show dialog for price input
      // final price = await showDialog<double>(
      //   context: context,
      //   builder: (context) => PriceInputDialog(),
      // );

      if (true) {
        setState(() {
          product.branches.add(Branch(
            branchId: result.id!,
            price: product.price,
            colors: [],
          ));
        });
      }
    }
  }

  void _navigateToColorSelection(int branchIndex) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ColorSelectionScreen(
                colorBloc: BlocProvider.of<ColorBloc>(myColorContext),
              )),
    );

    if (result != null && result is MyColor) {
      setState(() {
        product.branches[branchIndex].colors.add(
          Color(
            colorId: result.id!,
            sizes: [],
          ),
        );
      });
    }
  }

  void _navigateToSizeSelection(int branchIndex, int colorIndex) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SizeSelectionScreen(
          categoryId: widget.categories,
          sizeBloc: BlocProvider.of<SizeBloc>(mySizeContext),
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        product.branches[branchIndex].colors[colorIndex].sizes.add(
          Size(
            sizeId: result['sizeId'],
            quantity: result['quantity'],
          ),
        );
      });
    }
  }

  void _removeBranch(int index) {
    setState(() {
      product.branches.removeAt(index);
    });
  }

  void _removeColor(int branchIndex, int colorIndex) {
    setState(() {
      product.branches[branchIndex].colors.removeAt(colorIndex);
    });
  }

  void _removeSize(int branchIndex, int colorIndex, Size size) {
    setState(() {
      product.branches[branchIndex].colors[colorIndex].sizes.remove(size);
    });
  }

  void _saveProduct() {
    // Implement product saving logic here
    print('Product saved: ${product.toJson()}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product saved successfully')),
    );
  }
}
