import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/widget_extension.dart';
import '../themes/app_theme.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.onChanged,
    this.value,
    required this.hint,
    required this.items,
    required this.itemBuilder,
    this.validator,
    this.contentPadding,
    this.width,
    this.menuMaxHeight,
  });

  final List<T> items;
  final void Function(T?)? onChanged;
  final String Function(T?) itemBuilder;
  final T? value;
  final String hint;
  final String? Function(T?)? validator;
  final REdgeInsets? contentPadding;
  final double? width;
  final double? menuMaxHeight;
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<T>(
        menuMaxHeight: menuMaxHeight,
        validator: validator,
        hint: Text(
          hint,
          style: textTheme.titleLarge,
        ),
        value: value,
        items: List.generate(
          items.length,
          (index) => _buildDropdownMenuItem(items[index]),
        ),
        decoration: InputDecoration(
          // TODO: Responsive Padding (Test on web)
          contentPadding: (contentPadding == null && 1.sw > 650)
              ? EdgeInsets.all(24.h)
              : contentPadding,
        ),
        onChanged: onChanged,
      ).size(w: width),
    );
  }

  DropdownMenuItem<T> _buildDropdownMenuItem(T val) {
    return DropdownMenuItem<T>(
      value: val,
      child: Text(
        itemBuilder.call(val),
      ),
    );
  }
}
