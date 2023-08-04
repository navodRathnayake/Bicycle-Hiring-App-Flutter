library availability_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add A Credit Card',
                      style: themeData.textTheme.headlineSmall),
                  DialogBoxCloseButton(themeData: themeData),
                ],
              ),
              const Divider(),
              FormView(themeData: themeData)
            ],
          ),
        ),
        actions: <Widget>[
          // DialogBoxSecondaryButton(
          //     themeData: themeData,
          //     label: 'No,later',
          //     onTap: Navigator.of(context).pop),
          DialogBoxOkButton(label: 'Submit', onTap: Navigator.of(context).pop),
        ],
      );
    },
  );
}

class FormView extends StatelessWidget {
  final ThemeData themeData;
  const FormView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ColumnSpacer(height: 20),
        CustomInputField(
          formatter: creaditCardNumberMaskFormatter,
          labelText: 'Card Number',
          hintText: '1234-5678-9012-3456',
          imgUrl: 'Assets/icons/payment_type.png',
          keyboardType: TextInputType.number,
          maxLength: 19,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 130,
              child: CustomInputField(
                formatter: creaditCardDateMaskFormatter,
                labelText: 'Expiry Date',
                hintText: 'MM / YY',
                imgUrl: 'Assets/icons/payment_type.png',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
            const RowSpacer(width: 10),
            SizedBox(
              width: 130,
              child: CustomInputField(
                formatter: creaditCardCVCMaskFormatter,
                labelText: 'CVC/CVV',
                hintText: '123',
                imgUrl: 'Assets/icons/payment_type.png',
                keyboardType: TextInputType.number,
                maxLength: 3,
                obsecureText: true,
              ),
            ),
          ],
        ),
        const ColumnSpacer(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: 'Card Holder',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Enter Card Holder\'s Full Name',
            suffixIcon: Image.asset(
              'Assets/icons/card_payment.png',
              scale: 2,
            ),
          ),
          keyboardType: TextInputType.name,
          maxLength: 50,
          cursorWidth: 5,
          obscureText: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(value: true, onChanged: (isChecked) {}),
            const RowSpacer(width: 10),
            const Text('Save the payment method'),
          ],
        ),
      ],
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String imgUrl;
  final TextInputType keyboardType;
  final int maxLength;
  final bool obsecureText;
  final MaskTextInputFormatter formatter;
  const CustomInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.imgUrl,
    required this.keyboardType,
    required this.maxLength,
    required this.formatter,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [formatter],
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        suffixIcon: Image.asset(
          imgUrl,
          scale: 2,
        ),
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
      cursorWidth: 5,
      obscureText: obsecureText,
    );
  }
}
