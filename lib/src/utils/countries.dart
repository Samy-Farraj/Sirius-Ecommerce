class Country {

  static Iterable country(String countryCode) {
    String key = 'code';

    Iterable country = countries.where(
          (map) => map[key] == countryCode,
    );

    return country;
  }

  static String flag(String countryCode) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    String emoji =
        String.fromCharCode(firstChar) + String.fromCharCode(secondChar);

    return emoji;
  }

  static String flagByIndex(int index){
    String countryCode=countries[index]['code']!;
    return flag(countryCode);
  }

  static String labelPhone(String countryCode){
    final Map country = countries.where((element) => element['code']==countryCode).single;
    return country['label_phone']??'';
  }

  static List<Map<String, String>> countries = [   {
    'name': 'سوريا',
    'code': 'SY',
    'dial_code': '+963',
  },];
}
