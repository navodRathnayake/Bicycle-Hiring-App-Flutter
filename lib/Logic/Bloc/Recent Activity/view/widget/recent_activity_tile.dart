library recent_activity_tile;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:flutter/material.dart';

class RecentActivityTile extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String startLocation;
  final String endLocation;
  final ThemeData themeData;
  const RecentActivityTile(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.startLocation,
      required this.endLocation,
      required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.background,
          border: const Border(
              left:
                  BorderSide(color: Color.fromARGB(255, 54, 55, 56), width: 3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$startLocation - $endLocation',
                  style: themeData.textTheme.bodyLarge),
              const ColumnSpacer(height: 5),
              Text('$startTime - $endTime'),
            ],
          ),
        ),
      ),
    );
  }
}
