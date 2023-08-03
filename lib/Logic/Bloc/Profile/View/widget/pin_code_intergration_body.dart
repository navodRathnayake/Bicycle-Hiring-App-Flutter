library pin_code_intergration_bod;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/pin_code_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeIntergrationBody extends StatelessWidget {
  final ThemeData themeData;
  const PinCodeIntergrationBody({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    FocusNode otp1 = FocusNode();
    FocusNode otp2 = FocusNode();
    FocusNode otp3 = FocusNode();
    FocusNode otp4 = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const ColumnSpacer(height: 10),
            const Text(
              'Pin Code',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const ColumnSpacer(height: 10),
            const Text(
                'Sign in make happy to introduce the cycling with meat better transportation model. This is a sample text to show',
                textAlign: TextAlign.center),
            const ColumnSpacer(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<PinCodeFormBloc, PinCodeFormState>(
                builder: (context, state) {
                  return Form(
                    child: Column(
                      children: [
                        const ColumnSpacer(height: 20),
                        TextFormField(
                          initialValue: state.password.value,
                          decoration: InputDecoration(
                            errorText: state.password.displayError != null ||
                                    (state.password.isNotValid) &&
                                        (state.password.value.isNotEmpty)
                                ? 'Input your account password with correct length'
                                : null,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Password',
                            labelText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Image.asset(
                              'Assets/icons/password.png',
                              scale: 2,
                              color: themeData.colorScheme.onSecondaryContainer,
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onChanged: (password) {
                            BlocProvider.of<PinCodeFormBloc>(context).add(
                                PinCodePasswordChanged(password: password));
                          },
                        ),
                        const ColumnSpacer(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                initialValue: state.otp1.value,
                                focusNode: otp1,
                                onChanged: (value) {
                                  BlocProvider.of<PinCodeFormBloc>(context)
                                      .add(PinCodeOTP1Changed(otp1: value));
                                  if (value.isNotEmpty) {
                                    FocusScope.of(context).requestFocus(otp2);
                                  }
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  errorText: state.otp1.displayError != null
                                      ? ''
                                      : null,
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // hintText: '9',
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                            const Text('-'),
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                initialValue: state.otp2.value,
                                focusNode: otp2,
                                onChanged: (value) {
                                  BlocProvider.of<PinCodeFormBloc>(context)
                                      .add(PinCodeOTP2Changed(otp2: value));
                                  if (value.isNotEmpty) {
                                    FocusScope.of(context).requestFocus(otp3);
                                  }
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  errorText: state.otp2.displayError != null
                                      ? ''
                                      : null,

                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // hintText: '9',
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                            const Text('-'),
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                initialValue: state.otp3.value,
                                focusNode: otp3,
                                onChanged: (value) {
                                  BlocProvider.of<PinCodeFormBloc>(context)
                                      .add(PinCodeOTP3Changed(otp3: value));
                                  if (value.isNotEmpty) {
                                    FocusScope.of(context).requestFocus(otp4);
                                  }
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  errorText: state.otp3.displayError != null
                                      ? ''
                                      : null,
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // hintText: '9',
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                            const Text('-'),
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                initialValue: state.otp4.value,
                                focusNode: otp4,
                                onChanged: (value) {
                                  BlocProvider.of<PinCodeFormBloc>(context)
                                      .add(PinCodeOTP4Changed(otp4: value));
                                  if (value.isNotEmpty) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  errorText: state.otp4.displayError != null
                                      ? ''
                                      : null,
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // hintText: '9',
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                              ),
                            ),
                          ],
                        ),
                        const ColumnSpacer(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<PinCodeFormBloc>(context)
                                .add(PinCodeFormSubmitted());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeData.colorScheme.onBackground,
                            minimumSize: const Size(double.maxFinite, 56),
                            shape: const ContinuousRectangleBorder(),
                          ),
                          child: Text(
                            'CHANGE',
                            style: TextStyle(
                              fontSize: 20,
                              color: themeData.colorScheme.background,
                              letterSpacing: 10,
                            ),
                          ),
                        ),
                        const ColumnSpacer(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Why do I need to have a pin?'),
                            const RowSpacer(width: 5),
                            GestureDetector(
                              onTap: () {
                                Future.delayed(
                                    const Duration(milliseconds: 400),
                                    () async {
                                  Navigator.of(context).pop();
                                  // await logInGeneralDialogBox(
                                  //     context: context, themeData: themeData);
                                });
                              },
                              child: Text('See why',
                                  style: TextStyle(
                                    color: themeData
                                        .colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const ColumnSpacer(height: 20),
        Column(
          children: [
            const Text('Read the the terms and condition'),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Terms of Services & Privacy Policy.',
                style: TextStyle(
                  color: themeData.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
