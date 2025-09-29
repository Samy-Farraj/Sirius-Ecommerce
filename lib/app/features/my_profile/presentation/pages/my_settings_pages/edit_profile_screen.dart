import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sirius/app/features/auth/domain/entities/app_user.dart';
import 'package:sirius/app/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';
import '../../../../../../src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../../src/components/custom_text_field.dart';
import '../../../../../../src/components/error_screens/error_screen.dart';
import '../../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../../../src/validation/required_validator.dart';
import '../../../domain/usecases/edit_profile_use_case.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late String _selectedLang;
  late DateTime _selectedBirthDate;

  @override
  void initState() {
    super.initState();
  }

  File? _selectedProfilePhoto;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedProfilePhoto = File(pickedFile.path);
      });
    }
  }

  String? _selectedGender;

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: 'gender'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: [
        DropdownMenuItem(value: 'male', child: Text('male'.tr())),
        DropdownMenuItem(value: 'female', child: Text('female'.tr())),
      ],
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MyProfileBloc>()..add(GetProfileInfoEvent()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'edit_profile'.tr(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 35.h),
            child: BlocConsumer<MyProfileBloc, MyProfileState>(
              buildWhen: (previous, current) {
                return current is LoadingProfileDetailsState ||
                    current is DoneProfileDetailsState ||
                    current is ErrorProfileDetailsState;
              },
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ErrorProfileDetailsState) {
                  return ErrorScreen(
                    message: state.message!,
                    onRetry: () => BlocProvider.of<MyProfileBloc>(context)
                        .add(GetProfileInfoEvent()),
                  );
                } else if (state is LoadingProfileDetailsState) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 350.h),
                      child: SpinKitThreeBounce(
                        color: AppColors.primary,
                        size: 16.sp,
                      ),
                    ),
                  );
                } else if (state is DoneProfileDetailsState) {
                  if (isLoaded == false) {
                    isLoaded = true;
                    print("object");
                    _firstNameController =
                        TextEditingController(text: state.user!.name);

                    _phoneController =
                        TextEditingController(text: state.user!.phone);
                    _emailController =
                        TextEditingController(text: state.user!.email);
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfilePhoto(state.user!),
                      SizedBox(height: 25.h),
                      Text(
                        "edit_my_details".tr(),
                        style: textTheme.titleMedium,
                      ),
                      SizedBox(height: 11.h),
                      SizedBox(
                        width: 352.w,
                        child: TextFieldWithTitle(
                          title: "phone_number".tr(),
                          widget: TextFormFieldWidget(
                            prefix: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgIcon(
                                iconTitle: 'assets/icons/phone.svg',
                                w: 16.w,
                                h: 16.w,
                              ),
                            ),
                            label: _phoneController.text,
                            hintText: "phone_number".tr(),
                            controller: _phoneController,
                            validator: RequiredValidator(),
                            prefixConstraint:
                                BoxConstraints(maxHeight: 40.w, maxWidth: 40.w),
                          ),
                        ),
                      ),
                      SizedBox(height: 13.h),
                      SizedBox(
                        width: 352.w,
                        child: TextFieldWithTitle(
                            title: "email".tr(),
                            widget: TextFormFieldWidget(
                              prefixConstraint: BoxConstraints(
                                  maxHeight: 40.w, maxWidth: 40.w),
                              prefix: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgIcon(
                                  iconTitle: 'assets/icons/message.svg',
                                  w: 16.w,
                                  h: 16.w,
                                ),
                              ),
                              label: _emailController.text,
                              hintText: "email".tr(),
                              controller: _emailController,
                              validator: RequiredValidator(),
                            )),
                      ),
                      SizedBox(
                        height: 117.h,
                      ),
                      BlocConsumer<MyProfileBloc, MyProfileState>(
                        listener: (context, state) {
                          if (state is DoneEditProfileState) {
                            LocalStorage localStorage = sl.get<LocalStorage>();
                            var newInfoUser = localStorage.appUser!.copyWith(
                              phone: _phoneController.text,
                            );
                            //  localStorage.storeAppUser(AppUser());
                            print("SSSSSSSSSSSSSSSSSSSSS");
                            localStorage.storeAppUser(newInfoUser);
                            BlocProvider.of<MyProfileBloc>(context)
                                .add(GetProfileInfoEvent());
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            isLoading: state is LoadingEditProfileState,
                            text: "save".tr(),
                            color: Colors.red,
                            textColor: AppColors.white,
                            onPressed: () {
                              BlocProvider.of<MyProfileBloc>(context).add(
                                  EditProfileEvent(
                                      parameters: EditProfileParameter(
                                          logo: _selectedProfilePhoto,
                                          email: _emailController.text,
                                          phone: _phoneController.text)));
                            },
                            radius: 10,
                            isGradient: true,
                          );
                        },
                      )
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget itemInfoProfile(
      {required String title, required String value, required IconData icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(
            width: 9.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyLarge!.copyWith(color: AppColors.dark),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                value,
                style: textTheme.bodyLarge,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProfilePhoto(AppUser profile) {
    return Center(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: 94.w,
                height: 94.w,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _selectedProfilePhoto != null
                      ? FileImage(_selectedProfilePhoto!)
                      : (profile.logo != null
                              ? NetworkImage(profile.logo!)
                              : const AssetImage(
                                  'assets/images/default_profile.png'))
                          as ImageProvider,
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
          Positioned(
            bottom: 8,
            right: -4,
            child: Container(
              height: 35.w,
              width: 40.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.secondary]),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.white, size: 20.sp),
                  onPressed: _pickImage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
