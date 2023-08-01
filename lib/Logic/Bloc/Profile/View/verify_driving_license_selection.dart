library verify_driving_license_selection;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/avatar.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/points.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyDrivingLicenseSelection extends StatelessWidget {
  final ThemeData themeData;
  const VerifyDrivingLicenseSelection({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Image.asset(
                  'Assets/icons/back_arrow.png',
                  scale: 2,
                  color: themeData.colorScheme.onBackground,
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: PopUpSettingsMenu(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context),
                  icon: CustomSettingsIcon(
                    themeData: themeData,
                  ))),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const ColumnSpacer(height: 20),
                            ListTile(
                              title: const Text('Gallery'),
                              leading: Image.asset(
                                'Assets/icons/gallery.png',
                                scale: 2,
                                color: themeData.colorScheme.onBackground,
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: const Text('Camera'),
                              leading: Image.asset(
                                'Assets/icons/camera.png',
                                scale: 2,
                                color: themeData.colorScheme.onBackground,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Image.asset(
                  'Assets/icons/finger.png',
                  color: themeData.colorScheme.onBackground,
                  scale: 6,
                ),
              ),
              const ColumnSpacer(height: 30),
              const Text(
                'VERIFY',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10,
                ),
              ),
              const ColumnSpacer(height: 10),
              const Text(
                'YOUR ACCOUNT',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 10,
                ),
              ),
              const ColumnSpacer(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  useLicense,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
