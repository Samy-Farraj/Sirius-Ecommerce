import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sirius/app/features/offers/domain/usecases/store_new_offer_use_case.dart';
import 'package:sirius/app/features/offers/presentation/bloc/offers_bloc.dart';
import 'package:sirius/app/features/product/presentation/bloc/prodcut_bloc.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/routing/routes.dart';
import '../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../src/components/custom_text_field.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../../../src/validation/required_validator.dart';
import 'package:intl/intl.dart';

class AddOfferScreen extends StatefulWidget {
  List<String> productId;
  OffersBloc bloc;
  ProductBloc productBloc;
  AddOfferScreen({
    required this.bloc,
    required this.productId,
    required this.productBloc,
    Key? key,
  }) : super(key: key);

  @override
  _AddOfferScreenState createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController offerAmount = TextEditingController();
  late TextEditingController startDateController = TextEditingController();
  late TextEditingController endDateController = TextEditingController();
  String discountType = 'percentage';

  @override
  void dispose() {
    offerAmount.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(picked);
      setState(() {
        if (isStartDate) {
          startDateController.text = formattedDate;
        } else {
          endDateController.text = formattedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        appBar: CustomAppBar(title: 'add_offer'.tr()),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  Text("choose_offer_type".tr(), style: textTheme.titleMedium),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => discountType = 'percentage'),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: discountType == 'percentage'
                                  ? LinearGradient(
                                      colors: [
                                        Color(0xFF0AFAE3),
                                        Color(0xFFFA0AF2)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    )
                                  : null,
                              border: discountType != 'percentage'
                                  ? Border.all(
                                      color: AppColors.medium, width: 1.5)
                                  : null,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(0.5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 16.w),
                              child: Center(
                                  child: Text("percentage".tr(),
                                      style: textTheme.labelMedium)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => discountType = 'fixed'),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: discountType == 'fixed'
                                  ? LinearGradient(
                                      colors: [
                                        Color(0xFF0AFAE3),
                                        Color(0xFFFA0AF2)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    )
                                  : null,
                              border: discountType != 'fixed'
                                  ? Border.all(
                                      color: AppColors.medium, width: 1.5)
                                  : null,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(0.5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 16.w),
                              child: Center(
                                  child: Text("fixed".tr(),
                                      style: textTheme.labelMedium)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: 352.w,
                    child: TextFieldWithTitle(
                      title: "offer_amount".tr(),
                      widget: TextFormFieldWidget(
                        hintText: "offer_amount".tr(),
                        controller: offerAmount,
                        keyboardType: TextInputType.number,
                        validator: (discountType == 'fixed')
                            ? RequiredValidator()
                            : PercentageValidator(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 352.w,
                    child: TextFieldWithTitle(
                      title: "start_date".tr(),
                      widget: TextFormFieldWidget(
                        readOnly: true,
                        controller: startDateController,
                        hintText: "select_start_date".tr(),
                        validator: RequiredValidator(),
                        onTap: () => _selectDate(context, true),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 352.w,
                    child: TextFieldWithTitle(
                      title: "end_date".tr(),
                      widget: TextFormFieldWidget(
                        readOnly: true,
                        controller: endDateController,
                        hintText: "select_end_date".tr(),
                        validator: RequiredValidator(),
                        onTap: () => _selectDate(context, false),
                      ),
                    ),
                  ),
                  SizedBox(height: 117.h),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
          child: BlocConsumer<OffersBloc, OffersState>(
            listener: (context, state) {
              if (state is DoneStoreNewOfferState) {
                context.push(Routes.offers);
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: "add_offer".tr(),
                color: Colors.red,
                isGradient: true,
                isLoading: state is LoadingStoreNewOfferState,
                textColor: AppColors.white,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<OffersBloc>(context).add(
                      StoreNewOfferEvent(
                        parameter: StoreNewOfferParameter(
                          productId: widget.productId,
                          discountType: discountType,
                          discountAmount: offerAmount.text,
                          startDate: startDateController.text,
                          endDate: endDateController.text,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
