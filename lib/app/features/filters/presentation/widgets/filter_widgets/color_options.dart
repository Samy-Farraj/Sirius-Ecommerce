import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';

class ColorOptions extends StatelessWidget {
  final List<MyColor> colors;
  final List<String> selectedColorIds;
  final Function(List<String>) onChanged;

  const ColorOptions({
    super.key,
    required this.colors,
    required this.selectedColorIds,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final color = colors[index];
          final id = color.id.toString();
          final isSelected = selectedColorIds.contains(id);

          return GestureDetector(
            onTap: () {
              final newList = List<String>.from(selectedColorIds);
              if (isSelected) {
                newList.remove(id);
              } else {
                newList.add(id);
              }
              onChanged(newList);
            },
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse(
                    color.hashcode?.replaceAll('#', '0xff') ?? '0xff000000')),
                border: isSelected
                    ? Border.all(
                        color: Theme.of(context).colorScheme.primary, width: 3)
                    : null,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemCount: colors.length,
      ),
    );
  }
}
