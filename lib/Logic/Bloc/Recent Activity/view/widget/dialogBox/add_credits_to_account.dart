library add_creadits_to_account;

import 'package:dotted_border/dotted_border.dart';
import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/add_creadit_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
          child: BlocBuilder<AddCreaditFormBloc, AddCreaditFormState>(
            builder: (context, state) {
              if (state.status == FormzSubmissionStatus.initial) {
                return DoPaymentInitialView(
                    themeData: themeData, cardNumbers: cardNumbers);
              } else if (state.status == FormzSubmissionStatus.inProgress) {
                return const DoPaymentInprocessView();
              } else if (state.status == FormzSubmissionStatus.success) {
                return DoPaymentSuccessView(themeData: themeData);
              } else if (state.status == FormzSubmissionStatus.failure) {
                return DoPaymentFailureView(themeData: themeData);
              } else {
                return DoPaymentInitialView(
                    themeData: themeData, cardNumbers: cardNumbers);
              }
            },
          ),
        ),
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

class DoPaymentInitialView extends StatelessWidget {
  final ThemeData themeData;
  final List<String> cardNumbers;
  const DoPaymentInitialView(
      {super.key, required this.themeData, required this.cardNumbers});

  @override
  Widget build(BuildContext context) {
    return ListBody(
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
        BlocBuilder<AddCreaditFormBloc, AddCreaditFormState>(
          builder: (context, state) {
            return Form(
              child: Column(
                children: [
                  DropdownButtonFormField(
                    items: cardNumbers
                        .map((item) => DropdownMenuItem<String>(
                            value: item, child: Text(item)))
                        .toList(),
                    onChanged: (menuItemValue) {
                      BlocProvider.of<AddCreaditFormBloc>(context).add(
                          AddCreaditFormDropDownMenuChangedEvent(
                              menuItemValue: menuItemValue.toString()));
                    },
                    decoration: InputDecoration(
                      errorText:
                          state.menuStatus == DropDownMenuButtonStatus.initial
                              ? 'You mus have selected a creadit card'
                              : null,
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
                  TextFormField(
                    initialValue: state.amount.value,
                    decoration: InputDecoration(
                      errorText: state.amount.displayError != null ||
                              (state.amount.isNotValid) &&
                                  (state.amount.value.isNotEmpty)
                          ? 'Enter valid amount here. min 100 rupee '
                          : null,
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
                    onChanged: (amount) {
                      BlocProvider.of<AddCreaditFormBloc>(context).add(
                          AddCreaditFormAmountChangedEvent(amount: amount));
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const ColumnSpacer(height: 20),
        PaymentProcedureInfo(themeData: themeData),
        const ColumnSpacer(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DialogBoxOkButton(
                label: 'Ok, Re-Fill!',
                onTap: () {
                  BlocProvider.of<AddCreaditFormBloc>(context)
                      .add(AddCreaditFormSubmittedEvent());
                }),
          ],
        ),
      ],
    );
  }
}

class DoPaymentInprocessView extends StatelessWidget {
  const DoPaymentInprocessView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColumnSpacer(height: 30),
          CircularProgressIndicator(),
          ColumnSpacer(height: 10),
          Text('Adding Creadit',
              style: TextStyle(
                fontSize: 25,
              )),
          ColumnSpacer(height: 5),
          Text('Card',
              style: TextStyle(
                fontSize: 25,
              )),
          ColumnSpacer(height: 10),
          Text('It will take a while')
        ],
      ),
    );
  }
}

class DoPaymentSuccessView extends StatelessWidget {
  final ThemeData themeData;
  const DoPaymentSuccessView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/icons/ok.png',
                color: themeData.colorScheme.onBackground),
            const ColumnSpacer(height: 10),
            const Text('You Have',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 5),
            const Text('Added!',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 10),
            const Text(
              'Save the creadit card detail to make payment easy and secure',
              textAlign: TextAlign.center,
            ),
            const ColumnSpacer(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Continue'),
            )
          ],
        ),
      ),
    );
  }
}

class DoPaymentFailureView extends StatelessWidget {
  final ThemeData themeData;
  const DoPaymentFailureView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/icons/sad.png',
                color: themeData.colorScheme.onBackground),
            const ColumnSpacer(height: 10),
            const Text('Something',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 5),
            const Text('Went Wrong',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 5),
            const Text('Buddy!',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 10),
            const Text(
              'Try again to fill your account with points',
              textAlign: TextAlign.center,
            ),
            const ColumnSpacer(height: 30),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AddCreaditFormBloc>(context)
                    .add(AddCreaditFormRollBackEvent());
              },
              child: const Text('Try Again'),
            )
          ],
        ),
      ),
    );
  }
}
