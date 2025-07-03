List<int> getMonthAndYear(String value) {
  List<String> parts = value.split('/');
  int month = int.tryParse(parts[0]) ?? 0;
  int year = int.tryParse(parts[1]) ?? 0;

  return [month, year];
}
