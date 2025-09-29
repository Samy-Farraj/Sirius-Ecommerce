import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../src/themes/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Text(
          "HOME SCREEN",
          style: textTheme.headlineSmall,
        )));
  }
}
