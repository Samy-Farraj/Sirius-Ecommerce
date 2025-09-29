import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';
import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String get msgKey => LocaleKeys.required_validator_msg.tr();

  @override
  bool valid(String? input) => input != null && input.isNotEmpty;
}

class PercentageValidator extends BaseValidator {
  @override
  String get msgKey => "value_must_be_between_0_100".tr();

  @override
  bool valid(String? input) {
    if (input == null || input.isEmpty) return false;
    final numValue = double.tryParse(input);
    if (numValue == null) return false;
    return numValue >= 0 && numValue <= 100;
  }
}
