library validation_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_ok_button.dart';
import 'package:flutter/material.dart';

Future<void> validationDialogBox(
    {required BuildContext context,
    required ThemeData themeData,
    required String msg}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const ColumnSpacer(height: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: themeData.colorScheme.errorContainer,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: themeData.colorScheme.error,
                          child: Image.asset('Assets/icons/close.png',
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const ColumnSpacer(height: 20),
                  Text(msg, textAlign: TextAlign.center),
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          DialogBoxOkButton(
              label: 'Ok, Got it!', onTap: Navigator.of(context).pop),
        ],
      );
    },
  );
}
