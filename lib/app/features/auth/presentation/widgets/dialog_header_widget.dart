import 'package:flutter/material.dart';

import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';

class DialogHeaderWidget extends StatelessWidget {
  const DialogHeaderWidget({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: ()=>Navigator.pop(context),icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.dark)),
        Text(title,style: textTheme.displaySmall?.copyWith(color: AppColors.darkest),),
        const SizedBox.shrink(),
        const SizedBox.shrink()
      ],
    );
  }
}
