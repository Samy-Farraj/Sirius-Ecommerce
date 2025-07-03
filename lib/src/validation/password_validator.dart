import '../../generated/locale_keys.g.dart';
import 'base_validator.dart';

class PasswordValidator extends BaseValidator {
  @override
  String get msgKey => LocaleKeys.password_validator_msg;

  // todo
  @override
  bool valid(String? input) =>
      input != null &&
      input.length >=
          8; //RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(input);
}
