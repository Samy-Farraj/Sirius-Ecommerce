import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

String? requiredValidator(dynamic value) {
  if (value == null ||
      (value is String && value.replaceAll(" ", "").isEmpty ||
          value == 0.00 ||
          value == 0.0 ||
          value == "0.0" ||
          value == "0" ||
          value == "0.00")) {
    return "required_field".tr();
  }
  return null;
}

String? onlyEnglishValidator(dynamic value) {
  if (!RegExp(r'^[A-Za-z0-9_.]+').hasMatch((value as String?) ?? "")) {
    return "company_only_english_letters".tr();
  }
  return null;
}

String sanitizeString(String input) {
  final validCharacters = RegExp(r'[^a-zA-Z0-9_.]');
  return input.replaceAll(validCharacters, '');
}

String checkEnglishWordsAndNumbers(String input) {
  final pattern = RegExp(r'[a-zA-Z]+|\d+');
  final matches = pattern.allMatches(input);
  bool containsWords = false;
  bool containsNumbers = false;

  for (final match in matches) {
    if (match.group(0)!.contains(RegExp(r'[a-zA-Z]'))) {
      containsWords = true;
    } else if (match.group(0)!.contains(RegExp(r'\d'))) {
      containsNumbers = true;
    }
  }

  if (containsWords && containsNumbers) {
    return 'The input contains both English words and numbers.';
  } else if (containsWords) {
    return 'The input contains only English words.';
  } else if (containsNumbers) {
    return 'The input contains only numbers.';
  } else {
    return 'The input does not contain English words or numbers.';
  }
}

String? otpValidator(dynamic value) {
  String txt = value as String;
  if (txt.length < 4) {
    return 'otp_is_required'.tr();
  }
  return null;
}

String? emailValidator(dynamic value) {
  String txt = value as String;
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(txt)) {
    return 'invalid_email_address'.tr();
  }
  return null;
}

String? phoneValidator(dynamic value) {
  String txt = value as String;
  if (txt.length < 9 && txt.length > 10) {
    return 'validate_password'.tr();
  }
  return null;
}

String? passwordValidator(dynamic value) {
  String txt = value as String;
  if (txt.length < 8) {
    return 'validate_password'.tr();
  }
  return null;
}

String? taxNumberValidator(dynamic value) {
  String txt = value as String;
  if (txt.length > 0 && txt.length != 15) {
    return 'tax_number_validate'.tr();
  }
  return null;
}

String? passwordsMatchValidator(dynamic value, dynamic value2) {
  String txt = value as String;
  String txt2 = value2 as String;
  if (txt != txt2) {
    return 'كلمتا المرور غير متطابقتين';
  }
  return null;
}

String? moreThanZeroValidator(dynamic value) {
  if (double.parse((value as String?) ?? "0") <= 0) {
    return "more_than_zero".tr();
  }
  return null;
}

String? integerValidate(String value) {
  final parsed = int.tryParse(value);
  if (parsed == null) {
    return 'please_enter_an_integer_without_commas'.tr();
  }
  return null;
}

String? selectedCountryIdValidator(dynamic value) {
  if (value == null || (value is String && value.replaceAll(" ", "").isEmpty)) {
    return "please_select_country_from_list".tr();
  }
  return null;
}

String? selectedCityIdValidator(dynamic value) {
  if (value == null || (value is String && value.replaceAll(" ", "").isEmpty)) {
    return "please_select_city_from_list".tr();
  }
  return null;
}

String? selectedStateIdValidator(dynamic value) {
  if (value == null || (value is String && value.replaceAll(" ", "").isEmpty)) {
    return "please_select_state_from_list".tr();
  }
  return null;
}

String? selectedSenderNameValidator(dynamic value) {
  if (value == null || (value is String && value.replaceAll(" ", "").isEmpty)) {
    return "please_select_sender_from_list".tr();
  }
  return null;
}

String? selectedReceiverNameValidator(dynamic value) {
  if (value == null || (value is String && value.replaceAll(" ", "").isEmpty)) {
    return "please_select_receiver_from_list".tr();
  }
  return null;
}

String? LessThanTwo(dynamic value) {
  if (double.parse((value as String?) ?? "0") > 6) {
    return "less_than_six".tr();
  }
  return null;
}
