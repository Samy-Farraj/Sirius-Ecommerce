import 'package:easy_localization/easy_localization.dart';

abstract class BaseValidator {
  late final String msgKey;

  bool valid(String? input);

  String? validator(String? input) {
    if (!valid(input)) {
      return msgKey.tr();
    }
    return null;
  }
}
