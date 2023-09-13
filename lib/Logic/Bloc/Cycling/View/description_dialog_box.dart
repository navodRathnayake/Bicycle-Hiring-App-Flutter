library description_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/ride_bloc.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> descriptionDialogBox({
  required BuildContext context,
  required ThemeData themeData,
}) async {
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
                  TextFormField(
                    onChanged: (String description) {
                      BlocProvider.of<RideBloc>(context).add(
                          RideDescriptionOnChanged(description: description));
                    },
                    maxLines: 10,
                    maxLength: 100,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText:
                          'Enter the current falling emergency state to inform station and the team to get healp and recover',
                      labelText: 'Emergency Description',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          DialogBoxOkButton(
            label: 'Ok, Got it!',
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
