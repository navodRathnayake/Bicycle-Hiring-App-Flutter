library account_verify_app_bar;

import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountVerifyAppBar extends StatelessWidget {
  final ThemeData themeData;
  const AccountVerifyAppBar({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RowSpacer(width: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ACCOUNT',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 5,
                      color: themeData.colorScheme.onBackground,
                    )),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'VERIFICATION',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        PopUpSettingsMenu(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
          icon: SizedBox(
            width: 40,
            child: CustomSettingsIcon(
              themeData: themeData,
            ),
          ),
        ),
      ],
    );
  }
}
