library home_page;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/avatar.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/bottom_ui.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/breaker.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/points.dart';
import 'package:flutter/material.dart';
import 'Widget/custom_settings_icon.dart';
import 'Widget/home_dashboard.dart';
import 'Widget/popup_settings_menu.dart';

class HomePage extends StatelessWidget {
  final ThemeData themeData;
  const HomePage({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Points(themeData: themeData),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Avatar(),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: PopUpSettingsMenu(
                  icon: CustomSettingsIcon(
                themeData: themeData,
              ))),
        ],
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  HomeDashboard(themeData: themeData),
                  const Center(child: Breaker()),
                  BottomUI(themeData: themeData),
                ],
              ))),
    );
  }
}
