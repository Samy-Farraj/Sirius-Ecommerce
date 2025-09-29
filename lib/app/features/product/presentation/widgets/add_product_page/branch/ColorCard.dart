import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import '../../../../../../../src/themes/app_theme.dart';

class ColorCard extends StatelessWidget {
  final MyColor myColor;
  final int branchIndex;
  final int colorIndex;
  final Function(int, int) onRemove;

  const ColorCard({
    Key? key,
    required this.myColor,
    required this.branchIndex,
    required this.colorIndex,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (myColor.hashcode != null)
                  Container(
                    width: 16.w,
                    height: 16.w,
                    margin: EdgeInsets.only(right: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(
                        int.parse(myColor.hashcode!.replaceFirst('#', '0xFF')),
                      ),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                  ),
                SizedBox(width: 8),
                Text(
                  myColor.name ?? 'Color',
                  style: textTheme.titleSmall!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: () => onRemove(branchIndex, colorIndex),
            ),
          ],
        ),
      ],
    );
  }
}
