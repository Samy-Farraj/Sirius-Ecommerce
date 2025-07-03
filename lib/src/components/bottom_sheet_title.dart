// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../themes/app_theme.dart';

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: textTheme.titleLarge,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
