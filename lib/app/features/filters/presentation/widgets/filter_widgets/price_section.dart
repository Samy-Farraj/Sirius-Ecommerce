import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/app/features/product/data/models/PriceRangeFilterModel.dart';

class PriceSection extends StatefulWidget {
  final PriceRangeFilterModel? priceRange;
  final Function(double?, double?) onChanged;

  const PriceSection({
    super.key,
    required this.priceRange,
    required this.onChanged,
  });

  @override
  State<PriceSection> createState() => _PriceSectionState();
}

class _PriceSectionState extends State<PriceSection> {
  double? minValue;
  double? maxValue;

  @override
  void initState() {
    super.initState();
    minValue = widget.priceRange?.minPrice?.toDouble() ?? 0;
    maxValue = widget.priceRange?.maxPrice?.toDouble() ?? 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: RangeValues(minValue ?? 0, maxValue ?? 1000),
          min: widget.priceRange?.minPrice?.toDouble() ?? 0,
          max: widget.priceRange?.maxPrice?.toDouble() ?? 1000,
          divisions: 100,
          labels: RangeLabels(
            (minValue ?? 0).toStringAsFixed(0),
            (maxValue ?? 1000).toStringAsFixed(0),
          ),
          onChanged: (values) {
            setState(() {
              minValue = values.start;
              maxValue = values.end;
            });
            widget.onChanged(minValue, maxValue);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${minValue?.toStringAsFixed(0)}"),
              Text("${maxValue?.toStringAsFixed(0)}"),
            ],
          ),
        ),
      ],
    );
  }
}
