library cycling_page;

import 'package:flutter/material.dart';
import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/avatar.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/points.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';

class CyclingPage extends StatelessWidget {
  final ThemeData themeData;
  const CyclingPage({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScanQRView(themeData: themeData),
        ],
      ),
    );
  }
}

class ScanQRView extends StatelessWidget {
  final ThemeData themeData;
  const ScanQRView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const ColumnSpacer(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      'Assets/icons/qr.png',
                      color: themeData.colorScheme.onBackground,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 33,
                          backgroundColor: themeData.colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: themeData.colorScheme.secondary,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'Assets/icons/activities.png',
                                  scale: 1,
                                  color: themeData.colorScheme.background,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Assets/icons/c.png',
                    scale: 2,
                    color: themeData.colorScheme.primary,
                  ),
                  const RowSpacer(width: 10),
                  Text('RideSafe.org', style: themeData.textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Scan QR code to unlock your service bicycle to ride. Follow few steps to confirm and padal to the destination.',
                  textAlign: TextAlign.center,
                ),
              ),
              const ColumnSpacer(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/cyclingStepperPage');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Center(
                          child: Text(
                        'Tap to scan QR for unlock your bicycle',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
