library availability_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
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
              const Text(
                'Instructions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
              ),
              const ColumnSpacer(height: 10),
              const Text('Step 01',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Turn on the bicycle switch to access the QR code'),
              const Text('Step 02',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                  'Verify your account points that satisfying with your time-based package'),
              const Text('Step 03',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                  'Scan the QR code and complete the cycling steps including accept the agreement'),
              const Text('Step 04',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                  'Enjoy with smart lock and the display that installed in the bicycle and use the provided navigation functionalities to reach your destination'),
              const Text('Step 05',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                  'Finish your service at a registered bicycle sharing station'),
            ],
          ),
        ),
        actions: <Widget>[
          // DialogBoxSecondaryButton(
          //     themeData: themeData,
          //     label: 'No,later',
          //     onTap: Navigator.of(context).pop),
          DialogBoxOkButton(
              label: 'Ok, Got it!', onTap: Navigator.of(context).pop),
        ],
      );
    },
  );
}
