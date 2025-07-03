import 'base_validator.dart';

class PhoneValidator extends BaseValidator {
  String _countryCode;

  PhoneValidator(this._countryCode);

  void countryCode(String value) => _countryCode = value;

  @override
  String get msgKey => 'phone_validator_msg';

  @override
  bool valid(String? input) {
    if (input == null || input.isEmpty) {
      return false;
    }
    switch (_countryCode) {
      case 'SY':
        return validSy(input);
      case 'JO':
        return validJo(input);
      default:
        return true;
    }
  }

  bool validSy(String input) => RegExp(r'(^9\d{8}$)').hasMatch(input);

  bool validJo(String input) => RegExp(r'(^7\d{8}$)').hasMatch(input);
}
