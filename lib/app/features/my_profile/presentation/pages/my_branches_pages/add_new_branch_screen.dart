import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sirius/app/features/branches/presentation/bloc/branches_bloc.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/components/custom_text_form_field.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import 'package:sirius/src/routing/routes.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_theme.dart';
import '../../../../../../src/components/custom_text_field.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/utils/app_notifications.dart';
import '../../../../../../src/validation/required_validator.dart';
import '../../../../branches/domain/entities/branch.dart';
import '../../../../branches/domain/usecases/store_new_branch_use_case.dart';
import '../../../../city/domain/entities/city.dart';
import '../../../../city/presentation/bloc/city_bloc.dart';
import '../../bloc/my_profile_bloc.dart';
import '../../widgets/custom.dart';

class AddNewBranchScreen extends StatefulWidget {
  final String companyId;
  final MyProfileBloc profileBloc;
  final Branch? branch;
  final bool isEdit;

  const AddNewBranchScreen({
    required this.companyId,
    required this.isEdit,
    this.branch,
    required this.profileBloc,
    super.key,
  });

  @override
  State<AddNewBranchScreen> createState() => _AddNewBranchScreenState();
}

class _AddNewBranchScreenState extends State<AddNewBranchScreen> {
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.branch != null) {
      titleController.text = widget.branch!.title ?? '';

      WidgetsBinding.instance.addPostFrameCallback((_) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl.get<BranchesBloc>(),
        ),
        BlocProvider(
          create: (context) => sl.get<CityBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: widget.isEdit ? 'edit_branch'.tr() : 'add_branch'.tr(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 29.h, bottom: 29.h),
                child: Text(
                  widget.isEdit
                      ? 'edit_existing_branch'.tr()
                      : 'add_new_branch'.tr(),
                  style: textTheme.titleMedium,
                ),
              ),
              BlocBuilder<CityBloc, CityState>(
                builder: (context, state) {
                  return CustomDropdown(
                    bloc: BlocProvider.of<CityBloc>(context),
                    isEdit: widget.isEdit,
                    oldCity: widget.branch,
                    onCitySelected: (selectedCity) {
                      if (selectedCity != null) {
                        print('Selected City ID: ${selectedCity.id}');
                        print('Selected City Name: ${selectedCity.name}');
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 23.h),
              SizedBox(
                width: 352.w,
                child: TextFieldWithTitle(
                  title: "title".tr(),
                  widget: TextFormFieldWidget(
                    prefix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgIcon(
                        iconTitle: 'assets/icons/location_grey.svg',
                        w: 16.w,
                        h: 16.w,
                      ),
                    ),
                    hintText: "enter_your_title_location".tr(),
                    controller: titleController,
                    validator: RequiredValidator(),
                    prefixConstraint:
                        BoxConstraints(maxHeight: 40.w, maxWidth: 40.w),
                  ),
                ),
              ),
              SizedBox(height: 23.h),
              BlocBuilder<BranchesBloc, BranchesState>(
                builder: (context, state) {
                  if (widget.isEdit == true) {
                    final branchesBloc = context.read<BranchesBloc>();
                    branchesBloc.areaName = widget.branch!.address ?? "";
                    branchesBloc.newBranchLocation = LatLng(
                      double.tryParse(widget.branch!.latitude ?? "0") ?? 0,
                      double.tryParse(widget.branch!.longitude ?? "0") ?? 0,
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ti_address".tr(),
                        style: textTheme.labelMedium,
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.medium),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context.push(
                              Routes.determineBranchLocationMap,
                              extra: {'bloc': context.read<BranchesBloc>()},
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0.w),
                                    child: SvgIcon(
                                      iconTitle:
                                          'assets/icons/location_grey.svg',
                                    ),
                                  ),
                                  (BlocProvider.of<BranchesBloc>(context)
                                                  .areaName !=
                                              null &&
                                          BlocProvider.of<BranchesBloc>(context)
                                                  .areaName !=
                                              "")
                                      ? SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            BlocProvider.of<BranchesBloc>(
                                                    context)
                                                .areaName!,
                                            style:
                                                textTheme.bodyMedium!.copyWith(
                                              color: AppColors.grey,
                                            ),
                                          ),
                                        )
                                      : (widget.isEdit)
                                          ? SizedBox(
                                              width: 200.w,
                                              child: Text(
                                                widget.branch!.address ?? "",
                                                style: textTheme.bodyMedium!
                                                    .copyWith(
                                                        color: AppColors.grey),
                                              ),
                                            )
                                          : Text(
                                              "enter_your_address".tr(),
                                              style: textTheme.bodyMedium!
                                                  .copyWith(
                                                      color: AppColors.grey),
                                            ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.push(
                                    Routes.determineBranchLocationMap,
                                    extra: {
                                      'bloc': context.read<BranchesBloc>()
                                    },
                                  );
                                },
                                child: SvgIcon(
                                    iconTitle: 'assets/icons/address.svg'),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: BlocConsumer<BranchesBloc, BranchesState>(
            listener: (context, state) {
              if (state is DoneStoreNewBranchState ||
                  state is DoneUpdateBranchState) {
                widget.profileBloc.add(GetProfileInfoEvent());
                context.pop();
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: widget.isEdit ? 'save_changes'.tr() : 'add_new'.tr(),
                color: Colors.red,
                isLoading: state is LoadingStoreNewBranchState ||
                    state is LoadingUpdateBranchState,
                textColor: AppColors.white,
                onPressed: () {
                  print(
                      " BlocProvider.o      ${BlocProvider.of<CityBloc>(context).cityId.toString()}");
                  if (titleController.text.isNotEmpty &&
                      BlocProvider.of<BranchesBloc>(context).areaName != "") {
                    if (widget.isEdit == true) {
                      if (BlocProvider.of<CityBloc>(context)
                                  .cityId
                                  .toString() !=
                              "null" &&
                          BlocProvider.of<CityBloc>(context)
                                  .cityId
                                  .toString() !=
                              "") {
                        BlocProvider.of<BranchesBloc>(context).add(
                          UpdateBranchEvent(
                            parameter: NewBranchParameter(
                              branchId: widget.branch!.id.toString(),
                              cityId: BlocProvider.of<CityBloc>(context).cityId,
                              companyId: widget.companyId,
                              title: titleController.text,
                              address: BlocProvider.of<BranchesBloc>(context)
                                  .areaName!,
                              longitude: BlocProvider.of<BranchesBloc>(context)
                                  .newBranchLocation
                                  .longitude
                                  .toString(),
                              latitude: BlocProvider.of<BranchesBloc>(context)
                                  .newBranchLocation
                                  .latitude
                                  .toString(),
                            ),
                          ),
                        );
                      } else {
                        AppNotifications.showError(
                          message: 'please_fill_all_fields'.tr(),
                        );
                      }
                    } else {
                      BlocProvider.of<BranchesBloc>(context).add(
                        StoreNewBranchEvent(
                          parameter: NewBranchParameter(
                            cityId: BlocProvider.of<CityBloc>(context).cityId,
                            companyId: widget.companyId,
                            title: titleController.text,
                            address: BlocProvider.of<BranchesBloc>(context)
                                .areaName!,
                            longitude: BlocProvider.of<BranchesBloc>(context)
                                .newBranchLocation
                                .longitude
                                .toString(),
                            latitude: BlocProvider.of<BranchesBloc>(context)
                                .newBranchLocation
                                .latitude
                                .toString(),
                          ),
                        ),
                      );
                    }

                    //  id: widget.isEdit ? widget.branch?.id : null,
                  } else {
                    AppNotifications.showError(
                      message: 'please_fill_all_fields'.tr(),
                    );
                  }
                },
                isGradient: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
