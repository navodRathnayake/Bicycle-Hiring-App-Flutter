library pin_code_intergration_bod;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/pin_code_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeIntergrationBody extends StatefulWidget {
  final ThemeData themeData;
  const PinCodeIntergrationBody({super.key, required this.themeData});

  @override
  State<PinCodeIntergrationBody> createState() =>
      _PinCodeIntergrationBodyState();
}

class _PinCodeIntergrationBodyState extends State<PinCodeIntergrationBody> {
  FocusNode password = FocusNode();
  FocusNode otp1 = FocusNode();
  FocusNode otp2 = FocusNode();
  FocusNode otp3 = FocusNode();
  FocusNode otp4 = FocusNode();
  @override
  void dispose() {
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          focusNode: password,
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
                              color: widget
                                  .themeData.colorScheme.onSecondaryContainer,
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onChanged: (password) {
                            BlocProvider.of<PinCodeFormBloc>(context).add(
                                PinCodePasswordChanged(password: password));
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(otp1);
                            if (password.hasFocus) {
                              password.unfocus();
                            }
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
                                    // otp1.unfocus();
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
                                    // otp2.unfocus();
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
                                    // otp3.unfocus();
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
                            backgroundColor:
                                widget.themeData.colorScheme.onBackground,
                            minimumSize: const Size(double.maxFinite, 56),
                            shape: const ContinuousRectangleBorder(),
                          ),
                          child: Text(
                            'CHANGE',
                            style: TextStyle(
                              fontSize: 20,
                              color: widget.themeData.colorScheme.background,
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
                                    color: widget.themeData.colorScheme
                                        .onPrimaryContainer,
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
                  color: widget.themeData.colorScheme.onPrimaryContainer,
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

class PinCodeIntergrationBodyInProcess extends StatelessWidget {
  const PinCodeIntergrationBodyInProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          ColumnSpacer(height: 10),
          Text('Adding PIN',
              style: TextStyle(
                fontSize: 25,
              )),
          ColumnSpacer(height: 5),
          Text('Code',
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

class PinCodeIntergrationBodySuccess extends StatelessWidget {
  final ThemeData themeData;
  const PinCodeIntergrationBodySuccess({super.key, required this.themeData});

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
              'Use the entered pin code for secure your card details',
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

class PinCodeIntergrationBodyFailure extends StatelessWidget {
  final ThemeData themeData;
  const PinCodeIntergrationBodyFailure({super.key, required this.themeData});

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
                BlocProvider.of<PinCodeFormBloc>(context)
                    .add(PinCodeFormTryAgain());
              },
              child: const Text('Try Again'),
            )
          ],
        ),
      ),
    );
  }
}
