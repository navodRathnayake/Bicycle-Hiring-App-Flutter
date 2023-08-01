library recent_activity_app_bar;

import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentActivityAppBar extends StatelessWidget {
  final String title;
  final ThemeData themeData;
  const RecentActivityAppBar({
    super.key,
    required this.themeData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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
          Text(title, style: themeData.textTheme.headlineSmall),
          PopUpSettingsMenu(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
              icon: SizedBox(
                width: 40,
                child: CustomSettingsIcon(
                  themeData: themeData,
                ),
              ))
        ],
      ),
    );
  }
}
