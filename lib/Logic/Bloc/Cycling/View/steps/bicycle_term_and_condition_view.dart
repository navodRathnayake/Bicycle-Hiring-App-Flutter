library bicycle_term_and_condition_view;

import 'package:flutter/material.dart';
import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_secondary_button.dart';

class BicycleTermAndConditionView extends StatelessWidget {
  final ThemeData themeData;
  const BicycleTermAndConditionView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ColumnSpacer(height: 10),
                Text(
                  'AGREEMENT',
                  style: TextStyle(
                      color: themeData.colorScheme.secondary,
                      letterSpacing: 5,
                      fontSize: 15),
                ),
                const ColumnSpacer(height: 10),
                Text(
                  'Terms of Service',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    letterSpacing: 3,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const ColumnSpacer(height: 20),
                Text(
                  '1.Terms',
                  style: TextStyle(
                    color: themeData.colorScheme.onBackground,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const ColumnSpacer(height: 10),
                Text(
                  terms,
                  textAlign: TextAlign.justify,
                ),
                const ColumnSpacer(height: 10),
                Text(
                  '2.Use License',
                  style: TextStyle(
                    color: themeData.colorScheme.onBackground,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const ColumnSpacer(height: 10),
                Text(
                  useLicense,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogBoxSecondaryButton(
                    themeData: themeData,
                    label: 'D E C L I N E',
                    onTap: Navigator.of(context).pop),
                const RowSpacer(width: 10),
                DialogBoxOkButton(
                    label: 'A C C E P T', onTap: Navigator.of(context).pop),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
