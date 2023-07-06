library profile_activity_card;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/profile_line_chart.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/radial_chart.dart';
import 'package:flutter/material.dart';

import 'line_chart.dart';

class ProfileActivityCard extends StatelessWidget {
  final ThemeData themeData;
  const ProfileActivityCard({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: themeData.colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Portfolio activities',
                    style: themeData.textTheme.headlineSmall),
                Container(
                  child: Row(children: [
                    Image.asset(
                      'Assets/icons/card.png',
                      scale: 1,
                      color: themeData.colorScheme.onSecondaryContainer,
                    ),
                    const RowSpacer(width: 5),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: themeData.colorScheme.onSecondaryContainer,
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: Image.asset('Assets/icons/add.png', scale: 2),
                    // ),
                  ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Viewing last month transaction chart',
                        style: themeData.textTheme.titleSmall),
                    const ColumnSpacer(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: themeData.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('2,576',
                                style: themeData.textTheme.headlineSmall),
                            Text(
                              'Total Points',
                              style: themeData.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   width: 160,
                //   height: 160,
                //   child: RadialChart(),
                // )
              ],
            ),
            SizedBox(
              height: 100,
              child: ProfileLineChart(),
            )
          ],
        ),
      ),
    );
  }
}
