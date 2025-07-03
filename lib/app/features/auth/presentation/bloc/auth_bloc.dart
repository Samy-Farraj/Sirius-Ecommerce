import 'dart:async';

import 'package:osm/app/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../src/di/services_locator.dart';
import '../../../../../src/utils/constance.dart';
import '../../../../../src/utils/countries.dart';
import '../../../../../src/validation/phone_validator.dart';
import '../../domain/entities/user_id_holder.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/resend_code_usecase.dart';
import '../../domain/usecases/verify_code_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  LogOutUseCase logOutUseCase;
  final RegisterUseCase registerUseCase;
  final ResendCodeUseCase resendCodeUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;

  AuthBloc(
    this.logOutUseCase,
    this.loginUseCase,
    this.registerUseCase,
    this.resendCodeUseCase,
    this.verifyCodeUseCase,
  ) : super(AuthState()) {
    on<SelectCountryEvent>(_selectCountry);

    on<LoginEvent>(_login);
    on<LogOutEvent>(_logOut);
    on<SelectGenderEvent>(_selectedGender);
    on<SelectBirthDateEvent>(_selectedBirthDate);

    on<RegisterEvent>(_register);
    on<ResendCodeEvent>(_resendCode);
    on<VerifyEvent>(_verify);

    on<ResetTimerEvent>(_stopTimer);
    on<ChangeAgreeTerms>(_changeAgreeTerms);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyForStepOne = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyForStepTwo = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> createNewPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController forgotPasswordPhoneController =
      TextEditingController();

  final TextEditingController createNewPasswordController =
      TextEditingController();
  final TextEditingController createNewConfirmPasswordController =
      TextEditingController();

  final PhoneValidator phoneValidator = PhoneValidator(AppConst.countryCode);

  final List<TextEditingController> verifiedPhoneControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String phoneLabel = Country.labelPhone(AppConst.countryCode);
  String dialCode = Country.countries.firstWhere(
          (element) => element['code'] == AppConst.countryCode)['dial_code'] ??
      '';

  bool rememberMe = false;
  bool agreeTerms = false;

  int verificationCodeCurrentIndex = 0;

  FutureOr<void> _selectCountry(
      SelectCountryEvent event, Emitter<AuthState> emit) {
    phoneValidator.countryCode(event.countryCode);
    phoneLabel = Country.labelPhone(event.countryCode);
    dialCode = Country.countries.firstWhere(
            (element) => element['code'] == event.countryCode)['dial_code'] ??
        '';
    emit(state.copyWith(countryCode: event.countryCode.replaceAll('+', '')));
  }

  FutureOr<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loading: true));
    final result = await logOutUseCase(event.isDriver);
    result.fold(
      (l) {
        emit(state.copyWith(loading: false, isLogOut: false));

        hideLoading(emit);
        if (l.message.contains('hintMesage')) {
          //emit(GoToVerifyState());
        }
      },
      (r) {
        emit(state.copyWith(loading: false, isLogOut: true));
        emit(LogOutState());
        print("THEEEE SSSSS ISSSS }");
        // emit(GoToHome());
      },
    );
  }

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    showLoading(emit);
    final result = await loginUseCase(
      LoginParameters(
        rememberMe: rememberMe,
        phone: dialCode + phoneController.text,
      ),
    );
    result.fold(
      (l) {
        hideLoading(emit);
        if (l.message.contains('hintMesage')) {
          //emit(GoToVerifyState());
        }
      },
      (r) {
        emit(GoToVerifyState());
        // emit(GoToHome());
      },
    );
  }

  void _selectedBirthDate(SelectBirthDateEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(birthDate: event.birthDate));
  }

  void _selectedGender(SelectGenderEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  FutureOr<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    LocalStorage localStorage = sl.get<LocalStorage>();
    print("Stored FCM: ${await localStorage.fcmToken!}");
    print("Stored UUID: ${await localStorage.uuid!}");
    showLoading(emit);
    final result = await registerUseCase(
      RegisterParameters(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: dialCode + phoneController.text,
        macAddress: await localStorage.uuid!,
        notifcationToken: await localStorage.fcmToken!,
        birthDate:
            "${state.birthDate!.year}-${state.birthDate!.month}-${state.birthDate!.day}",
        lang: 'ar',
        gender: state.gender,
        profilePhoto: '',
      ),
    );
    print("TEST BLOC REGISTER 1:::");

    result.fold(
      (l) {
        print("TEST BLOC REGISTER 2:::");
        print("TEST BLOC REGISTER 2:::${l.message}");
        print("TEST BLOC REGISTER 2:::${l}");

        hideLoading(emit);
      },
      (r) {
        print("TEST BLOC REGISTER 3:::");
        emit(GoToHome());
      },
    );
  }

  FutureOr<void> _resendCode(
      ResendCodeEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(resendButtonLoading: true));
    final result = await resendCodeUseCase(
      ResendCodeParameters(
        username: event.phone,
      ),
    );
    result.fold(
      (l) {
        emit(state.copyWith(resendButtonLoading: false));
      },
      (r) {
        emit(state.copyWith(resendButtonLoading: false, startTimer: true));
      },
    );
  }

  FutureOr<void> _verify(VerifyEvent event, Emitter<AuthState> emit) async {
    showLoading(emit);
    LocalStorage localStorage = sl.get<LocalStorage>();
    print("Stored FCM: ${await localStorage.fcmToken!}");
    print("Stored UUID: ${await localStorage.uuid!}");
    final result = await verifyCodeUseCase(
      VerifyCodeParameters(
        code: verifiedPhoneControllers.getCode,
        phone: dialCode + event.phone.split(' ')[1],
        notification_token: await localStorage.fcmToken!,
      ),
    );
    result.fold(
      (l) {
        hideLoading(emit);
      },
      (r) {
        print("THE R TOKEN IS ${r.token}");
        print("THE R TOKEN IS ${r.user}");
        if (r.token == "" || r.token!.isEmpty) {
          emit(GoToRegister());
        } else {
          emit(GoToHome());
        }
      },
    );
  }

  // FutureOr<void> _forgetVerify(
  //     ForgetPasswordCodeVerifyEvent event, Emitter<AuthState> emit) async {
  //   showLoading(emit);
  //   final result = await forgetPasswordCodeVerifyUseCase(ForgetPasswordCodeVerifyParameter(
  //     username: event.phone.split(' ')[1],
  //     code: verifiedPhoneControllers.getCode,
  //   ));
  //   result.fold(
  //     (l) {
  //       hideLoading(emit);
  //     },
  //     (r) {
  //       sl.registerSingleton<UserIdHolder>(r);
  //       emit(GoToReset());
  //     },
  //   );
  // }

  void hideLoading(Emitter<AuthState> emit) {
    emit(state.copyWith(loading: false));
  }

  void showLoading(Emitter<AuthState> emit) {
    emit(state.copyWith(loading: true));
  }

  FutureOr<void> _stopTimer(ResetTimerEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(startTimer: false));
  }

  FutureOr<void> _changeAgreeTerms(
      ChangeAgreeTerms event, Emitter<AuthState> emit) {
    agreeTerms = !agreeTerms;
    emit(state.copyWith(agreeTerms: agreeTerms));
  }
}

extension GetCode on List<TextEditingController> {
  String get getCode {
    String c = '';
    forEach((element) {
      c = '$c${element.text}';
    });
    return c;
  }
}
