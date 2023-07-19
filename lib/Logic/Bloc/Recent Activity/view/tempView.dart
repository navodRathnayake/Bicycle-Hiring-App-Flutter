library temp_view;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:flutter/material.dart';

class TempView extends StatelessWidget {
  final ThemeData themeData;
  const TempView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: Column(
        children: [
          const ColumnSpacer(height: 20),
          const CustomInputField(
            labelText: 'Card Number',
            hintText: '1234-5678-9012-3456',
            imgUrl: 'Assets/icons/payment_type.png',
            keyboardType: TextInputType.number,
            maxLength: 16,
          ),
          Row(
            children: const [
              SizedBox(
                width: 150,
                child: CustomInputField(
                  labelText: 'Expiry Date',
                  hintText: 'MM / YY',
                  imgUrl: 'Assets/icons/payment_type.png',
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),
              ),
              RowSpacer(width: 10),
              SizedBox(
                width: 150,
                child: CustomInputField(
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
          CustomInputField(
            labelText: 'Card Holder',
            hintText: 'Enter Card Holder\'s Full Name',
            imgUrl: 'Assets/icons/card_payment.png',
            keyboardType: TextInputType.name,
            maxLength: 50,
          )
        ],
      ),
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
  const CustomInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.imgUrl,
    required this.keyboardType,
    required this.maxLength,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
