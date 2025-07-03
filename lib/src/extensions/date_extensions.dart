extension DateExtensions on String {
  DateTime formattedDate() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      final res1 = split(' ')[0];
      final res11 = res1.split('-');
      final reversed = res11.reversed.toList();
      final reversedWithDash = reversed.fold('', (previousValue, element) {
        if (previousValue != '') {
          return '$previousValue-$element';
        }
        return element;
      });

      final res2 = split(' ')[1];

      final res = '$reversedWithDash $res2';
      return DateTime.parse(res);
    }
  }
}
