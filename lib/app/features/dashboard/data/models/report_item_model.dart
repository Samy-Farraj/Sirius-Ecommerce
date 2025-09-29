class ReportItem {
  final String? date;
  final String? label;
  final int? value;

  ReportItem({
    this.date,
    this.label,
    this.value,
  });

  factory ReportItem.fromJson(Map<String, dynamic> map) {
    return ReportItem(
      date: map['date'] != null ? map['date'] as String : null,
      label: map['label'] != null ? map['label'] as String : null,
      value: map['value'] != null ? map['value'] as int : null,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};
    if (date != null) result['date'] = date;
    if (label != null) result['label'] = label;
    if (value != null) result['value'] = value;
    return result;
  }
}
