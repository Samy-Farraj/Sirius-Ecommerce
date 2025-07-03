import '../../generated/locale_keys.g.dart';
import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String get msgKey => LocaleKeys.required_validator_msg;

  @override
  bool valid(String? input) => input != null && input.isNotEmpty;
}
