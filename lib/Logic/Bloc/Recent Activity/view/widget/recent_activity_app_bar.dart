library recent_activity_app_bar;

import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:flutter/material.dart';

class RecentActivityAppBar extends StatelessWidget {
  final ThemeData themeData;
  const RecentActivityAppBar({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              'Assets/icons/back_arrow.png',
              scale: 2,
            )),
        PopUpSettingsMenu(
            icon: SizedBox(
          width: 40,
          child: CustomSettingsIcon(
            themeData: themeData,
          ),
        ))
      ],
    );
  }
}
