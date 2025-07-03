import '../../generated/locale_keys.g.dart';
import 'base_validator.dart';

class EmailValidator extends BaseValidator {
  @override
  String get msgKey => LocaleKeys.email_validator_msg;

  @override
  bool valid(String? input) => (input == null || input.isEmpty)
      ? true
      : RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(input);
}
