import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/themes/app_theme.dart';

class FallbackScreen extends StatelessWidget {
  const FallbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          'This Screen Under Progress !',
          style: textTheme.displayMedium,
        ),
      ),
    );
  }
}
