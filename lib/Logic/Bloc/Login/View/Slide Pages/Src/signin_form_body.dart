library signing_form_body;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/dialogBox/login_general_dialogbox.dart';
import 'package:final_project/Logic/Bloc/Login/auth/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigningFormBody extends StatefulWidget {
  final ThemeData themeData;
  const SigningFormBody({super.key, required this.themeData});

  @override
  State<SigningFormBody> createState() => _SigningFormBodyState();
}

class _SigningFormBodyState extends State<SigningFormBody> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // _emailFocusNode.addListener(() {
    //   if (!_emailFocusNode.hasFocus) {
    //     BlocProvider.of<RegisterFormBloc>(context).add(EmailUnfocused());
    //     FocusScope.of(context).requestFocus(_passwordFocusNode);
    //   }
    // });

    // _passwordFocusNode.addListener(() {
    //   if (!_passwordFocusNode.hasFocus) {
    //     BlocProvider.of<RegisterFormBloc>(context).add(PasswordUnfocused());
    //     FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
    //   }
    // });

    // _confirmPasswordFocusNode.addListener(() {
    //   if (!_confirmPasswordFocusNode.hasFocus) {
    //     BlocProvider.of<RegisterFormBloc>(context)
    //         .add(ConfirmPasswordUnfocused());
    //   }
    // });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
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
              'Sign In',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const ColumnSpacer(height: 10),
            // const Text(
            // 'Sign in make happy to introduce the cycling with meat better transportation model.',
            // textAlign: TextAlign.center),
            const ColumnSpacer(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                child: Column(
                  children: [
                    EmailTextField(
                        themeData: widget.themeData, focusNode: emailFocusNode),
                    const ColumnSpacer(height: 20),
                    PasswordTextField(
                        themeData: widget.themeData,
                        focusNode: passwordFocusNode),
                    const ColumnSpacer(height: 20),
                    ConfirmPasswordTextField(
                        themeData: widget.themeData,
                        focusNode: confirmPasswordFocusNode),
                    const ColumnSpacer(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        Future.delayed(const Duration(milliseconds: 400), () {
                          emailFocusNode.unfocus();
                          passwordFocusNode.unfocus();
                          confirmPasswordFocusNode.unfocus();
                        });
                        BlocProvider.of<RegisterFormBloc>(context)
                            .add(RegisterFormSubmitted());
                        // Future.delayed(Duration(milliseconds: 400), () {
                        //   _confirmPasswordFocusNode.dispose();
                        //   _emailFocusNode.dispose();
                        //   _passwordFocusNode.dispose();
                        // });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            widget.themeData.colorScheme.onBackground,
                        minimumSize: const Size(double.maxFinite, 56),
                        shape: const ContinuousRectangleBorder(),
                      ),
                      child: Text(
                        'NEXT',
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
                        const Text('Already have an account?'),
                        const RowSpacer(width: 5),
                        GestureDetector(
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 400),
                                () async {
                              Navigator.of(context).pop();
                              await logInGeneralDialogBox(
                                  context: context,
                                  themeData: widget.themeData);
                            });
                          },
                          child: Text('Log In',
                              style: TextStyle(
                                color: widget
                                    .themeData.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const ColumnSpacer(height: 20),
        Column(
          children: [
            const Text('By signing up, you agree to'),
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

class EmailTextField extends StatelessWidget {
  final FocusNode focusNode;
  final ThemeData themeData;
  const EmailTextField(
      {super.key, required this.themeData, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      builder: (context, state) {
        return TextFormField(
          autofocus: true,
          initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            // helperText: 'A complete, valid email e.g. joe@gmail.com',
            // helperMaxLines: 2,
            errorText: state.email.displayError != null ||
                    (state.email.isNotValid) && (state.email.value.isNotEmpty)
                ? 'Please ensure the email entered is valid'
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Sample@email.com',
            labelText: 'User Name',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: state.email.isNotValid && !state.email.isPure
                ? Image.asset(
                    'Assets/icons/email.png',
                    scale: 2,
                    color: themeData.colorScheme.tertiary,
                  )
                : Image.asset(
                    'Assets/icons/email.png',
                    scale: 2,
                    color: themeData.colorScheme.onSecondaryContainer,
                  ),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) {
            BlocProvider.of<RegisterFormBloc>(context)
                .add(EmailChanged(email: email));
          },
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final FocusNode focusNode;
  final ThemeData themeData;
  const PasswordTextField(
      {super.key, required this.themeData, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            // helperText:
            //     '''Password should be at least 8 characters with at least one letter and number''',
            // helperMaxLines: 2,
            errorText: state.password.displayError != null ||
                    (state.password.isNotValid) &&
                        (state.password.value.isNotEmpty)
                ? '''Password must be at least 8 characters and contain at least one letter and number'''
                : null,
            errorMaxLines: 2,
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
            BlocProvider.of<RegisterFormBloc>(context)
                .add(PasswordChanged(password: password));
          },
        );
      },
    );
  }
}

class ConfirmPasswordTextField extends StatelessWidget {
  final FocusNode focusNode;
  final ThemeData themeData;
  const ConfirmPasswordTextField(
      {super.key, required this.themeData, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.confirmPassword.value,
          // focusNode: focusNode,
          decoration: InputDecoration(
            // helperText:
            //     '''Confirm password should be match with above inserted password''',
            // helperMaxLines: 2,
            errorText: state.confirmPassword.value != state.password.value &&
                    state.password.isValid
                ? '''Confirm password must be match with above inserted password'''
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Confirm Password',
            labelText: 'Confirm Password',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Image.asset(
              'Assets/icons/password.png',
              scale: 2,
              color: themeData.colorScheme.onSecondaryContainer,
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          onChanged: (confirmPassword) {
            BlocProvider.of<RegisterFormBloc>(context)
                .add(ConfirmPasswordChanged(confirmPassword: confirmPassword));
          },
        );
      },
    );
  }
}
