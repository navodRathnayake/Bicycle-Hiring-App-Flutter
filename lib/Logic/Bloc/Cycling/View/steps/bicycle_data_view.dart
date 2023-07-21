library bicycle_data_view;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/avatar.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/points.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:flutter/material.dart';

class BicycleDataView extends StatelessWidget {
  final ThemeData themeData;
  const BicycleDataView({super.key, required this.themeData});

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
            child: Container(
              decoration: BoxDecoration(
                color: themeData.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'Assets/icons/close.png',
                scale: 2,
              ),
            ),
          ),
        ),
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
        children: [
          const ColumnSpacer(height: 40),
          Stack(
            children: [
              const Positioned(
                right: -50,
                child: CircleAvatar(
                  radius: 170,
                  backgroundColor: Colors.amber,
                ),
              ),
              const Positioned(
                left: 10,
                bottom: 20,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.amber,
                ),
              ),
              const Positioned(
                left: 30,
                bottom: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 40, right: 20, bottom: 50),
                child: Image.asset('Assets/icons/bicycle_sharing.png'),
              ),
            ],
          ),
          const ColumnSpacer(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VEHICLE MAX HIEGHT',
                      style: themeData.textTheme.bodyLarge,
                    ),
                    const ColumnSpacer(height: 5),
                    const Text(
                      '150 - 170 cm',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BIKE WEIGHT',
                      style: themeData.textTheme.bodyLarge,
                    ),
                    const ColumnSpacer(height: 5),
                    const Text('12 kg',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const ColumnSpacer(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SERVICE STATION',
                      style: themeData.textTheme.bodyLarge,
                    ),
                    const ColumnSpacer(height: 5),
                    const Text(
                      'PERADENIYA',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BIKE MANUF:',
                      style: themeData.textTheme.bodyLarge,
                    ),
                    const ColumnSpacer(height: 5),
                    const Text(
                      '2019',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          const ColumnSpacer(height: 10),
          const Text(
            'This bicycle sharing rental sysytem is implemented as a transportation model for Sri Lanka.',
            textAlign: TextAlign.center,
          ),
          const ColumnSpacer(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/bicyclePackageView');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, right: 15, bottom: 8, left: 16),
                child: Text('RENT A BICYCLE',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
