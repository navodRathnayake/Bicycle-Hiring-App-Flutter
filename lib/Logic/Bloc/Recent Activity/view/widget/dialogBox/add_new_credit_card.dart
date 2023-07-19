library availability_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_secondary_button.dart';
import 'package:flutter/material.dart';

Future<void> addNewCreditCardDialogBox(
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Add New Credit Card',
                      style: themeData.textTheme.headlineSmall),
                  DialogBoxCloseButton(themeData: themeData),
                  const ColumnSpacer(height: 10),
                ],
              ),
              const Divider(),
              Container(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '1234-5678-9101-2345',
                    labelText: 'Card Number',
                  ),
                ),
              ),
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
