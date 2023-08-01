library route_page_app_bar;

import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutePageAppBar extends StatelessWidget {
  final String startLocation;
  final String endLocation;
  final String startTime;
  final String endTime;
  final String day;
  final int date;
  final ThemeData themeData;
  const RoutePageAppBar({
    super.key,
    required this.themeData,
    required this.startLocation,
    required this.endLocation,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Route',
              style: TextStyle(
                color: themeData.colorScheme.onSecondaryContainer,
              ),
            ),
            Text(
              '$startLocation to $endLocation',
              style: themeData.textTheme.headlineMedium,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.lock_clock),
                ),
                Text(
                  '$day $date - $startTime',
                  style: TextStyle(
                    color: themeData.colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            )
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
