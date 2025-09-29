import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../custom_navigation_bar.dart';

class PageViewer extends StatelessWidget {
  const PageViewer(this.child, {super.key});
  final StatefulNavigationShell child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomNavigationBar(child: child),
    );
  }
}
