import 'base_validator.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

class ConfirmPasswordValidator extends BaseValidator{

  final TextEditingController passwordController;

  ConfirmPasswordValidator(this.passwordController);

  @override
  String get msgKey => LocaleKeys.confirm_password_validator_msg;

  @override
  bool valid(String? input) =>
      input != null && passwordController.text==input;

}