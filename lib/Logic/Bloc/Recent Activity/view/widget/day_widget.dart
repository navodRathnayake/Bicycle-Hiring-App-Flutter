library day_widget;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final String day;
  final int date;
  final bool isSelected;
  final ThemeData themeData;
  const DayWidget(
      {super.key,
      required this.day,
      required this.date,
      required this.isSelected,
      required this.themeData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(day),
            const ColumnSpacer(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: isSelected
                      ? themeData.colorScheme.secondaryContainer
                      : themeData.colorScheme.background,
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date.toString(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
