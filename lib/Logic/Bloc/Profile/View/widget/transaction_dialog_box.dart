library transaction_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_secondary_button.dart';
import 'package:flutter/material.dart';

import 'custom_transaction_list_tile.dart';

Future<void> transactionDialogBox(
    {required BuildContext context, required ThemeData themeData}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Account Transaction',
                      style: themeData.textTheme.headlineSmall),
                  DialogBoxCloseButton(themeData: themeData),
                ],
              ),
              const Divider(),
              const ColumnSpacer(height: 10),
              CustomTransactionListTile(
                  themeData: themeData,
                  type: 1,
                  date: 'Jan-23-2023',
                  amount: 2375),
              CustomTransactionListTile(
                  themeData: themeData,
                  type: 2,
                  date: 'Jan-23-2023',
                  amount: 2375),
              CustomTransactionListTile(
                  themeData: themeData,
                  type: 2,
                  date: 'Jan-23-2023',
                  amount: 2375),
              CustomTransactionListTile(
                  themeData: themeData,
                  type: 1,
                  date: 'Jan-23-2023',
                  amount: 2375),
            ],
          ),
        ),
        actions: <Widget>[
          DialogBoxSecondaryButton(
              themeData: themeData,
              label: 'No,later',
              onTap: Navigator.of(context).pop),
          DialogBoxOkButton(
              label: 'Ok, Got it!', onTap: Navigator.of(context).pop),
        ],
      );
    },
  );
}
