library availability_dialog_box;

import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_secondary_button.dart';
import 'package:flutter/material.dart';

Future<void> availabilityDialogBox(
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
                  DialogBoxCloseButton(themeData: themeData),
                ],
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
