library otp_code_body;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/dialogBox/signin_general_dialogbox.dart';
import 'package:final_project/Logic/Bloc/Login/auth/forget%20password/confirm%20otp/confirm_otp_bloc.dart';
import 'package:final_project/Logic/Bloc/Login/auth/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class OTPCodeBody extends StatefulWidget {
  final ThemeData themeData;

  const OTPCodeBody({super.key, required this.themeData});

  @override
  State<OTPCodeBody> createState() => _OTPCodeBodyState();
}

class _OTPCodeBodyState extends State<OTPCodeBody> {
  FocusNode otp1 = FocusNode();

  FocusNode otp2 = FocusNode();

  FocusNode otp3 = FocusNode();

  FocusNode otp4 = FocusNode();

  bool isKeyBoardDown = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 10,
          child: GestureDetector(
            onTap: () {
              Future.delayed(const Duration(microseconds: 400), () async {
                Navigator.of(context).pop();
                await signInGeneralDialogBox(
                    context: context, themeData: widget.themeData);
              });
            },
            child: Image.asset(
              'Assets/icons/back_ios.png',
              scale: 1.5,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                ColumnSpacer(height: 10),
                Column(
                  children: [
                    Text(
                      'Verify email',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ColumnSpacer(height: 10),
                Text(
                    'Sign in make happy to introduce the cycling with meat better transportation model. This is a sample text to show',
                    textAlign: TextAlign.center),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                child: Column(
                  children: [
                    BlocBuilder<RegisterFormBloc, RegisterFormState>(
                      builder: (context, state) {
                        return TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: state.email.value,
                            labelText: 'User Name',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Image.asset(
                              'Assets/icons/email.png',
                              scale: 2,
                              color: widget
                                  .themeData.colorScheme.onSecondaryContainer,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        );
                      },
                    ),
                    const ColumnSpacer(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 50,
                          child: BlocBuilder<ConfirmOTPBloc, ConfirmOTPState>(
                            builder: (context, state) {
                              return TextFormField(
                                initialValue: state.otp1.value,
                                focusNode: otp1,
                                onChanged: (value) {
                                  BlocProvider.of<ConfirmOTPBloc>(context)
                                      .add(ConfirmOTP1Changed(otp1: value));
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
                              );
                            },
                          ),
                        ),
                        const Text('-'),
                        SizedBox(
                          width: 50,
                          child: BlocBuilder<ConfirmOTPBloc, ConfirmOTPState>(
                            builder: (context, state) {
                              return TextFormField(
                                initialValue: state.otp2.value,
                                focusNode: otp2,
                                onChanged: (value) {
                                  BlocProvider.of<ConfirmOTPBloc>(context)
                                      .add(ConfirmOTP2Changed(otp2: value));
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
                              );
                            },
                          ),
                        ),
                        const Text('-'),
                        SizedBox(
                          width: 50,
                          child: BlocBuilder<ConfirmOTPBloc, ConfirmOTPState>(
                            builder: (context, state) {
                              return TextFormField(
                                initialValue: state.otp3.value,
                                focusNode: otp3,
                                onChanged: (value) {
                                  BlocProvider.of<ConfirmOTPBloc>(context)
                                      .add(ConfirmOTP3Changed(otp3: value));
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
                              );
                            },
                          ),
                        ),
                        const Text('-'),
                        SizedBox(
                          width: 50,
                          child: BlocBuilder<ConfirmOTPBloc, ConfirmOTPState>(
                            builder: (context, state) {
                              return TextFormField(
                                initialValue: state.otp4.value,
                                focusNode: otp4,
                                onChanged: (value) {
                                  BlocProvider.of<ConfirmOTPBloc>(context)
                                      .add(ConfirmOTP4Changed(otp4: value));
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ConfirmOTPBloc>(context)
                        .add(ConfirmOTPFormSubmitted());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.themeData.colorScheme.onBackground,
                    minimumSize: const Size(double.maxFinite, 56),
                    shape: const ContinuousRectangleBorder(),
                  ),
                  child: Text(
                    'VERIFY',
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
                    const Text('Did not recieve code yet?'),
                    const RowSpacer(width: 5),
                    GestureDetector(
                      onTap: () {},
                      child: Text('Request',
                          style: TextStyle(
                            color:
                                widget.themeData.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
                Text('Get via email',
                    style: TextStyle(
                      color: widget.themeData.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const ColumnSpacer(height: 20),
            Column(
              children: [
                const Text('Before you register, please refer'),
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
        ),
      ],
    );
  }
}
