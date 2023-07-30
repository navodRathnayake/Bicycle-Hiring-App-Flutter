library login_form_body;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/dialogBox/forgot_password_general_dialogbox.dart';
import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/dialogBox/signin_general_dialogbox.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormBody extends StatefulWidget {
  final ThemeData themeData;
  const LoginFormBody({super.key, required this.themeData});

  @override
  State<LoginFormBody> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          children: [
            ColumnSpacer(height: 10),
            Text(
              'Log In',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
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
                LoginEmailField(
                    themeData: widget.themeData, focusNode: _emailFocusNode),
                const ColumnSpacer(height: 20),
                LoginPasswordTextField(
                    themeData: widget.themeData, focusNode: _passwordFocusNode),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await forgotPasswordGeneralDialogBox(
                            context: context, themeData: widget.themeData);
                      },
                      child: Text('Forgot Password?',
                          style: TextStyle(
                            color:
                                widget.themeData.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          )),
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
                BlocProvider.of<LoginFormBloc>(context)
                    .add(LoginFormSubmitted());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.themeData.colorScheme.onBackground,
                minimumSize: const Size(double.maxFinite, 56),
                shape: const ContinuousRectangleBorder(),
              ),
              child: Text(
                'LOGIN',
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
                const Text('Do not have an account?'),
                const RowSpacer(width: 5),
                GestureDetector(
                  onTap: () {
                    Future.delayed(const Duration(microseconds: 400), () async {
                      Navigator.of(context).pop();
                      await signInGeneralDialogBox(
                          context: context, themeData: widget.themeData);
                    });
                  },
                  child: Text('Sign In',
                      style: TextStyle(
                        color: widget.themeData.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ],
        ),
        const ColumnSpacer(height: 20),
        Column(
          children: [
            const Text('By logining up, you agree to'),
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

class LoginEmailField extends StatelessWidget {
  final ThemeData themeData;
  final FocusNode focusNode;
  const LoginEmailField(
      {super.key, required this.themeData, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            errorText: state.email.displayError != null ||
                    (state.email.isNotValid) && (state.email.value.isNotEmpty)
                ? 'Please ensure the email entered is valid'
                : null,
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Sample@email.com',
            labelText: 'User Name',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Image.asset(
              'Assets/icons/email.png',
              scale: 2,
              color: themeData.colorScheme.onSecondaryContainer,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) {
            BlocProvider.of<LoginFormBloc>(context)
                .add(EmailChanged(email: email));
          },
        );
      },
    );
  }
}

class LoginPasswordTextField extends StatelessWidget {
  final ThemeData themeData;
  final FocusNode focusNode;
  const LoginPasswordTextField(
      {super.key, required this.themeData, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            errorText: state.email.displayError != null ||
                    (state.email.isNotValid) && (state.email.value.isNotEmpty)
                ? 'Please ensure the email entered is valid'
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
            BlocProvider.of<LoginFormBloc>(context)
                .add(PasswordChanged(password: password));
          },
        );
      },
    );
  }
}
