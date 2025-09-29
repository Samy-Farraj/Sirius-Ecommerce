import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sirius/app/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:sirius/app/features/product/presentation/bloc/prodcut_bloc.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import 'package:sirius/src/routing/routes.dart';
import 'package:sirius/src/utils/app_notifications.dart';
import '../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../src/components/custom_text_field.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../../../src/validation/required_validator.dart';
import '../../../categories/domain/entities/category.dart';
import '../../data/models/NewProductParameter.dart';
import '../widgets/categories_custom_dropdown.dart';
import '../widgets/gender_custom_dropdown.dart';

class AddProductScreen extends StatefulWidget {
  String categoryId;
  bool isEdit;
  NewProductParameter? productToEdit;
  ProductBloc oldBloc;
  List<Category> categoriesChildren = [];
  AddProductScreen({
    required this.categoryId,
    required this.isEdit,
    this.productToEdit,
    required this.oldBloc,
    required this.categoriesChildren,
    Key? key,
  }) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController productNameController = TextEditingController();
  late TextEditingController productPriceController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  String selectedGender = 'male';
  bool isSelectGender = false;
  bool isSelectCategories = false;
  String selectedCategoriesId = '';

  @override
  void initState() {
    super.initState();
    if (widget.isEdit == true) {
      _loadOldImages();
      selectedGender = widget.productToEdit!.gender.toString();
      selectedCategoriesId = widget.productToEdit!.categories.toString();
      productNameController.text = widget.productToEdit!.name.toString();
      productPriceController.text = widget.productToEdit!.price.toString();
      descriptionController.text = widget.productToEdit!.description.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadOldImages() async {
    if (widget.productToEdit?.oldImageUrl != null) {
      for (var imageModel in widget.productToEdit!.oldImageUrl!) {
        if (imageModel.url != null && imageModel.url!.isNotEmpty) {
          final file = await urlToFile(imageModel.url!);
          setState(() {
            productImages.add(file);
          });
        }
      }
    }
  }

  Future<File> urlToFile(String imageUrl) async {
    // جلب البايتات
    final response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getTemporaryDirectory();
    final file = File(
        '${documentDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png');

    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }

  List<File> productImages = [];

  File? emptyFile = File('empty');

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        productImages.addAll(pickedFiles.map((e) => File(e.path)));
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("categoriesChildren${widget.categoriesChildren}");
    return BlocProvider.value(
      value: widget.oldBloc,
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.isEdit ? 'edit_product'.tr() : 'add_product'.tr(),
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        SizedBox(
                          height: 180.h,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productImages.length + 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 220.w + 80.w,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              if (index == productImages.length) {
                                // زر إضافة صور
                                return InkWell(
                                  onTap: _pickImages,
                                  child: Container(
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.medium,
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgIcon(
                                          iconTitle:
                                              'assets/icons/upload_image.svg',
                                          w: 25.w,
                                          h: 25.w,
                                        ),
                                        SizedBox(height: 9.4.h),
                                        Text(
                                          'upload_image'.tr(),
                                          style: textTheme.labelLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        productImages[index],
                                        fit: BoxFit.cover,
                                        width: 250.w,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            productImages.removeAt(index);
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.black54,
                                          child: Icon(Icons.close,
                                              color: Colors.white, size: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 23.h),
                        SizedBox(
                          width: 352.w,
                          child: TextFieldWithTitle(
                            title: "product_name".tr(),
                            widget: TextFormFieldWidget(
                              hintText: "product_name".tr(),
                              controller: productNameController,
                              validator: RequiredValidator(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: 352.w,
                          child: TextFieldWithTitle(
                            title: "product_price".tr(),
                            widget: TextFormFieldWidget(
                              hintText: "product_price".tr(),
                              controller: productPriceController,
                              validator: RequiredValidator(),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CategoriesCustomDropdown(
                          onCategorySelected: (selectedCategory) {
                            if (selectedCategory != null) {
                              print(
                                  'Selected selectedCategory ID: ${selectedCategory.id}');

                              setState(() {
                                selectedCategoriesId =
                                    selectedCategory.id.toString();
                                isSelectCategories = true;
                              });
                            }
                          },
                          bloc: BlocProvider.of<ProductBloc>(context),
                          categoriesChildren: widget.categoriesChildren,
                        ),
                        SizedBox(height: 16.h),
                        GenderCustomDropdown(
                          currentValue: widget.productToEdit?.gender,
                          onGenderSelected: (selectedListGender) {
                            if (selectedListGender != null) {
                              print('Selected City ID: ${selectedListGender}');
                              setState(() {
                                selectedGender = selectedListGender;
                                isSelectGender = true;
                              });
                              //  print('Selected City Name: ${selectedCategory.name}');
                            }
                          },
                          bloc: BlocProvider.of<ProductBloc>(context),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: 352.w,
                          child: TextFieldWithTitle(
                            title: "description".tr(),
                            widget: TextFormFieldWidget(
                              maxLines: 5,
                              hintText: "description".tr(),
                              controller: descriptionController,
                              validator: RequiredValidator(),
                            ),
                          ),
                        ),
                        SizedBox(height: 13.h),
                        SizedBox(height: 20.h),
                      ],
                    );
                  },
                )),
          ),
        ),
        bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: MediaQuery.of(context).viewInsets.bottom > 0
                    ? MediaQuery.of(context).viewInsets.bottom + 10.h
                    : 30.h,
              ),
              child: CustomButton(
                  text: "next_step".tr(),
                  color: Colors.red,
                  isGradient: true,
                  textColor: AppColors.white,
                  onPressed: () async {
                    if ([].isEmpty == true) {
                      isSelectCategories = true;
                    }
                    // BlocProvider.of(context)
                    log("productImages${productImages}");
                    if (productImages == null && widget.isEdit == false) {
                      AppNotifications.showError(
                          message: 'please_fill_image'.tr());
                    } else if (isSelectGender == false) {
                      AppNotifications.showError(
                          message: 'please_select_gender'.tr());
                    } else if (isSelectCategories == false) {
                      AppNotifications.showError(
                          message: 'please_select_category'.tr());
                    } else {
                      if (_formKey.currentState!.validate()) {
                        if (widget.isEdit == true) {
                          context.push(Routes.addProductStepTow, extra: {
                            'isEdit': true,
                            'productToEdit': widget.productToEdit,
                            'name': productNameController.text,
                            'description': descriptionController.text,
                            "gender": selectedGender,
                            "bloc": BlocProvider.of<ProductBloc>(context),
                            "isOnSale": "0",
                            'isReplaceable': '0',
                            "isRefundable": "0",
                            "points": "0",
                            "categories": widget.categoryId,
                            "categoryChildId": selectedCategoriesId,
                            "productImages": productImages ?? [],
                            "productPrice": productPriceController.text
                          });
                        } else {
                          context.push(Routes.addProductStepTow, extra: {
                            'isEdit': false,
                            'name': productNameController.text,
                            'description': descriptionController.text,
                            "gender": selectedGender,
                            "bloc": BlocProvider.of<ProductBloc>(context),
                            "isOnSale": "0",
                            'isReplaceable': '0',
                            "isRefundable": "0",
                            "points": "0",
                            "categories": widget.categoryId,
                            "categoryChildId": selectedCategoriesId,
                            "productImages": productImages,
                            "productPrice": productPriceController.text
                          });
                        }
                      }
                    }
                  }),
            );
          },
        ),
      ),
    );
  }
}
