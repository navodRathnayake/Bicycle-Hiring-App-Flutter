library base_layout;

import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final ThemeData themeData;
  const BaseLayout({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: themeData.colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
