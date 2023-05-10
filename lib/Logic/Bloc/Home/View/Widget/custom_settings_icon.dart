library custom_settings_icon;

import 'package:flutter/material.dart';

class CustomSettingsIcon extends StatefulWidget {
  final ThemeData themeData;
  const CustomSettingsIcon({super.key, required this.themeData});

  @override
  State<CustomSettingsIcon> createState() => _CustomSettingsIconState();
}

class _CustomSettingsIconState extends State<CustomSettingsIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButtonTheme(
      data: widget.themeData.iconButtonTheme,
      child: Image.asset(
        'Assets/icons/setting.png',
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
