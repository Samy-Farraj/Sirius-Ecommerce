import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalOptions<T> extends StatelessWidget {
  final List<T> options;
  final List<String> selected;
  final String Function(T) getId;
  final String Function(T) getDisplayName;
  final Function(String) onSelect;

  const HorizontalOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.getId,
    required this.getDisplayName,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final option = options[index];
          final id = getId(option);
          final isSelected = selected.contains(id);

          return ChoiceChip(
            label: Text(getDisplayName(option)),
            selected: isSelected,
            onSelected: (_) => onSelect(id),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemCount: options.length,
      ),
    );
  }
}
