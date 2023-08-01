library add_creadits_to_account;

import 'package:dotted_border/dotted_border.dart';
import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_secondary_button.dart';
import 'package:flutter/material.dart';

Future<void> addCreaditToAccount(
    {required BuildContext context,
    required ThemeData themeData,
    required List<String> cardNumbers}) async {
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
                  Text('Refill Your Account',
                      style: themeData.textTheme.headlineSmall),
                  DialogBoxCloseButton(themeData: themeData),
                ],
              ),
              const Divider(),
              const ColumnSpacer(height: 10),
              DropdownButtonFormField(
                items: cardNumbers
                    .map((item) => DropdownMenuItem<String>(
                        value: item, child: Text(item)))
                    .toList(),
                onChanged: (item) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Card Number',
                  hintText: '1234-5678-9012-3456',
                  suffixIcon: Image.asset(
                    'Assets/icons/card_payment.png',
                    scale: 2,
                    color: themeData.colorScheme.secondary,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const ColumnSpacer(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Amount',
                  hintText: '550.00',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Image.asset('Assets/icons/coin.png',
                      scale: 2, color: themeData.colorScheme.secondary),
                ),
                cursorWidth: 5,
                keyboardType: TextInputType.number,
              ),
              const ColumnSpacer(height: 20),
              PaymentProcedureInfo(themeData: themeData),
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

class PaymentProcedureInfo extends StatelessWidget {
  final ThemeData themeData;
  const PaymentProcedureInfo({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.green,
      strokeWidth: 3,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Image.asset('Assets/icons/ok.png', scale: 2),
                ),
                const RowSpacer(width: 10),
                Text('Payment Procedure', style: themeData.textTheme.bodyLarge)
              ],
            ),
            const ColumnSpacer(height: 10),
            const Text(
                'we\'ll wory about all the transactions and payment. You can sit back and relax while you make your clients happy.'),
          ],
        ),
      ),
    );
  }
}
