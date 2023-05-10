library home_dashboard;

import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dashboard/base_layout.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/test.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'src/dashboard/Rounded_layout.dart';
import 'src/dashboard/bloc_layout.dart';
import 'chart_layout.dart';

class HomeDashboard extends StatelessWidget {
  final ThemeData themeData;
  const HomeDashboard({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.amber,
      child: SizedBox(
        width: double.maxFinite,
        height: 500,
        child: Stack(
          children: [
            Positioned(
              top: 25,
              left: 20,
              width: screenWidth - 50,
              height: screenWidth,
              child: BaseLayout(themeData: themeData),
            ),
            Positioned(
              top: 0,
              right: 30,
              child: RoundedLayout(themeData: themeData),
            ),
            Positioned(
              top: 80,
              left: 0,
              child: RoundedLayout(themeData: themeData),
            ),
            Positioned(
              top: 160,
              left: 40,
              height: 120,
              child: BlocLayout(themeData: themeData),
            ),
            Positioned(
              top: 160,
              right: 30,
              width: 180,
              height: 120,
              child: MyHomePage(themeData: themeData),
            ),
          ],
        ),
      ),
    );
  }
}
