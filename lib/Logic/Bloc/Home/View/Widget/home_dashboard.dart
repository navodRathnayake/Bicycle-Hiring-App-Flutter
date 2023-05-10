library home_dashboard;

import 'package:flutter/material.dart';

class HomeDashboard extends StatelessWidget {
  final ThemeData themeData;
  const HomeDashboard({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      color: Colors.grey,
    );
  }
}
