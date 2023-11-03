library pin_confirm_dialogBox;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_ok_button.dart';
import 'package:final_project/Logic/Bloc/SecurePin/secure_confirm_otp_bloc.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

Future<void> pinConfirmDialogBox({
  required BuildContext context,
  required ThemeData themeData,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 250,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: BlocProvider(
              create: (context) => SecureConfirmOTPBloc(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('PIN Required',
                          style: themeData.textTheme.headlineSmall),
                      DialogBoxCloseButton(themeData: themeData),
                    ],
                  ),
                  const Divider(),
                  const ColumnSpacer(height: 30),
                  BlocBuilder<SecureConfirmOTPBloc, SecureConfirmOTPState>(
                    builder: (context, state) {
                      if (state.status == FormzSubmissionStatus.initial) {
                        return LocalPinBody();
                      } else if (state.status ==
                          FormzSubmissionStatus.inProgress) {
                        return const LocalPinInprocess();
                      } else if (state.status ==
                          FormzSubmissionStatus.failure) {
                        return const LocalPinFailure();
                      } else {
                        return const LocalPinFailure();
                      }
                    },
                  ),
                  const ColumnSpacer(height: 30),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class LocalPinBody extends StatefulWidget {
  LocalPinBody({super.key});

  @override
  State<LocalPinBody> createState() => _LocalPinBodyState();
}

class _LocalPinBodyState extends State<LocalPinBody> {
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
    return Form(
      child: Builder(builder: (context) {
        return BlocBuilder<SecureConfirmOTPBloc, SecureConfirmOTPState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        autofocus: true,
                        initialValue: state.otp1.value,
                        focusNode: otp1,
                        onChanged: (value) {
                          BlocProvider.of<SecureConfirmOTPBloc>(context)
                              .add(SecureConfirmOTP1Changed(otp1: value));
                          if (value.isNotEmpty) {
                            FocusScope.of(context).requestFocus(otp2);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          errorText:
                              state.otp1.displayError != null ? '' : null,
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
                          BlocProvider.of<SecureConfirmOTPBloc>(context)
                              .add(SecureConfirmOTP2Changed(otp2: value));
                          if (value.isNotEmpty) {
                            FocusScope.of(context).requestFocus(otp3);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          errorText:
                              state.otp2.displayError != null ? '' : null,
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
                          BlocProvider.of<SecureConfirmOTPBloc>(context)
                              .add(SecureConfirmOTP3Changed(otp3: value));
                          if (value.isNotEmpty) {
                            FocusScope.of(context).requestFocus(otp4);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          errorText:
                              state.otp3.displayError != null ? '' : null,
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
                          BlocProvider.of<SecureConfirmOTPBloc>(context)
                              .add(SecureConfirmOTP4Changed(otp4: value));
                          if (value.isNotEmpty) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          errorText:
                              state.otp4.displayError != null ? '' : null,
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
                const ColumnSpacer(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DialogBoxOkButton(
                        label: 'Submit',
                        onTap: () async {
                          var otp = await SqfliteHelper.instance.readOTPData();
                          String stateOTP = state.otp1.value +
                              state.otp2.value +
                              state.otp3.value +
                              state.otp4.value;

                          BlocProvider.of<SecureConfirmOTPBloc>(context)
                              .add(SecureConfirmOTPFormSubmitted());

                          if (state.isValid &&
                              otp['otp'].toString() == stateOTP) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('/billing');
                          } else {
                            BlocProvider.of<SecureConfirmOTPBloc>(context)
                                .add(SecureSubmitFailure());
                          }
                        }),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

class LocalPinInprocess extends StatelessWidget {
  const LocalPinInprocess({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          ColumnSpacer(height: 30),
          Text('It will take a while'),
        ],
      ),
    );
  }
}

class LocalPinFailure extends StatelessWidget {
  const LocalPinFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Did Not Match!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const ColumnSpacer(height: 10),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<SecureConfirmOTPBloc>(context)
                    .add(SecureSubmitInitial());
              },
              child: const Text('Try Again'))
        ],
      ),
    );
  }
}
