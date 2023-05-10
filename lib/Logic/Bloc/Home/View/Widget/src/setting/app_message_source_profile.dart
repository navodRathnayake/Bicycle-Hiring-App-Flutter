library app_message_source_profile;

import 'package:flutter/material.dart';

class AppMessageSourceProfile extends StatelessWidget {
  final ThemeData themeData;
  const AppMessageSourceProfile({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: IconButtonTheme(
          data: themeData.iconButtonTheme,
          child: Image.asset(
            'Assets/Icons/brain.png',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
