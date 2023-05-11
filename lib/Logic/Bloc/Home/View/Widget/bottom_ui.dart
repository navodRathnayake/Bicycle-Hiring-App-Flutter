library bottom_ui;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class BottomUI extends StatelessWidget {
  final ThemeData themeData;
  const BottomUI({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12, bottom: 0),
              child: Row(
                children: [
                  Text('Your Padels', style: themeData.textTheme.bodyLarge),
                ],
              ),
            ),
            const Divider(),
            const ColumnSpacer(height: 5),
            CustomTabBar(
              themeData: themeData,
            )
          ],
        ),
      ),
    ));
  }
}
