library availability_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/add_new_creadit_card_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
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
              BlocBuilder<AddNewCreaditCardBloc, AddNewCreaditCardState>(
                builder: (context, state) {
                  if (state.status == FormzSubmissionStatus.initial) {
                    return const AddNewCreaditCardFormField();
                  } else if (state.status == FormzSubmissionStatus.inProgress) {
                    return const AddNewCreaditCardInprocess();
                  } else if (state.status == FormzSubmissionStatus.success) {
                    return AddNewCreaditCardSuccess(themeData: themeData);
                  } else if (state.status == FormzSubmissionStatus.failure) {
                    return AddNewCreaditCardFailure(themeData: themeData);
                  } else {
                    return FormView(themeData: themeData);
                  }
                },
              )
            ],
          ),
        ),
      );
    },
  );
}

class FormView extends StatelessWidget {
  final ThemeData themeData;
  const FormView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return const AddNewCreaditCardFormField();
  }
}

class AddNewCreaditCardFormField extends StatelessWidget {
  const AddNewCreaditCardFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewCreaditCardBloc, AddNewCreaditCardState>(
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              const ColumnSpacer(height: 20),
              TextFormField(
                initialValue: state.cardNumber.value,
                inputFormatters: [creaditCardNumberMaskFormatter],
                decoration: InputDecoration(
                  errorText: state.cardNumber.displayError != null ||
                          (state.cardNumber.isNotValid) &&
                              (state.cardNumber.value.isNotEmpty)
                      ? 'Enter valid creadit card number '
                      : null,
                  labelText: 'Card Number',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: '1234-5678-9012-3456',
                  suffixIcon: Image.asset(
                    'Assets/icons/payment_type.png',
                    scale: 2,
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 19,
                cursorWidth: 5,
                obscureText: false,
                onChanged: (cardNumber) {
                  BlocProvider.of<AddNewCreaditCardBloc>(context).add(
                      AddNewCreaditCardNumberChanged(cardNumber: cardNumber));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 130,
                    child:
                        // CustomInputField(
                        //   formatter: creaditCardDateMaskFormatter,
                        //   labelText: 'Expiry Date',
                        //   hintText: 'MM / YY',
                        //   imgUrl: 'Assets/icons/payment_type.png',
                        //   keyboardType: TextInputType.number,
                        //   maxLength: 5,
                        // ),
                        TextFormField(
                      initialValue: state.expiryDate.value,
                      inputFormatters: [creaditCardDateMaskFormatter],
                      decoration: InputDecoration(
                        errorText: state.expiryDate.displayError != null ||
                                (state.expiryDate.isNotValid) &&
                                    (state.expiryDate.value.isNotEmpty)
                            ? 'Enter valid expiry date here '
                            : null,
                        labelText: 'Expiry Date',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'MM / YY',
                        suffixIcon: Image.asset(
                          'Assets/icons/payment_type.png',
                          scale: 2,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      cursorWidth: 5,
                      obscureText: false,
                      onChanged: (expirydate) {
                        BlocProvider.of<AddNewCreaditCardBloc>(context).add(
                            AddNewCreaditCardExpiryDateChanged(
                                expiryDate: expirydate));
                      },
                    ),
                  ),
                  const RowSpacer(width: 10),
                  SizedBox(
                    width: 130,
                    child: TextFormField(
                      initialValue: state.cvv.value,
                      inputFormatters: [creaditCardCVCMaskFormatter],
                      decoration: InputDecoration(
                        errorText: state.cvv.displayError != null ||
                                (state.cvv.isNotValid) &&
                                    (state.cvv.value.isNotEmpty)
                            ? 'Enter valid cvv number here'
                            : null,
                        labelText: 'CVC/CVV',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: '123',
                        suffixIcon: Image.asset(
                          'Assets/icons/payment_type.png',
                          scale: 2,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      cursorWidth: 5,
                      obscureText: true,
                      onChanged: (cvv) {
                        BlocProvider.of<AddNewCreaditCardBloc>(context)
                            .add(AddNewCreaditCardCVVChanged(cvv: cvv));
                      },
                    ),
                  ),
                ],
              ),
              const ColumnSpacer(height: 10),
              TextFormField(
                initialValue: state.holderName.value,
                decoration: InputDecoration(
                  labelText: 'Card Holder',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  errorText: state.holderName.displayError != null ||
                          (state.holderName.isNotValid) &&
                              (state.holderName.value.isNotEmpty)
                      ? 'Enter valid holder name here'
                      : null,
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
                onChanged: (holderName) {
                  BlocProvider.of<AddNewCreaditCardBloc>(context).add(
                      AddNewCreaditCardHolderNameChanged(
                          holderName: holderName));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: true, onChanged: (isChecked) {}),
                  const RowSpacer(width: 10),
                  const Text('Save the payment method'),
                ],
              ),
              const ColumnSpacer(height: 10),
              Row(
                children: [
                  DialogBoxOkButton(
                      label: 'Submit',
                      onTap: () {
                        BlocProvider.of<AddNewCreaditCardBloc>(context)
                            .add(AddNewCreaditCardFormSubmittedEvent());
                      }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddNewCreaditCardInprocess extends StatelessWidget {
  const AddNewCreaditCardInprocess({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

class AddNewCreaditCardSuccess extends StatelessWidget {
  final ThemeData themeData;
  const AddNewCreaditCardSuccess({super.key, required this.themeData});

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
              'USave the creadit card detail to make payment easy and secure',
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

class AddNewCreaditCardFailure extends StatelessWidget {
  final ThemeData themeData;
  const AddNewCreaditCardFailure({super.key, required this.themeData});

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
              'Try again to add your pin code to secure your process',
              textAlign: TextAlign.center,
            ),
            const ColumnSpacer(height: 30),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AddNewCreaditCardBloc>(context)
                    .add(AddNewCreaditCardFormRollBackEvent());
              },
              child: const Text('Try Again'),
            )
          ],
        ),
      ),
    );
  }
}
