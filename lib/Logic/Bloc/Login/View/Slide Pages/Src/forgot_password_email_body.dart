library forgot_password_email_body;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/dialogBox/signin_general_dialogbox.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEmailBody extends StatelessWidget {
  final ThemeData themeData;
  const ForgotPasswordEmailBody({super.key, required this.themeData});

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
              'Forgot Password',
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
                TextFormField(
                  decoration: InputDecoration(
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
                ),
                const ColumnSpacer(height: 20),
                TextFormField(
                  decoration: InputDecoration(
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
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: themeData.colorScheme.onBackground,
                minimumSize: const Size(double.maxFinite, 56),
                shape: const ContinuousRectangleBorder(),
              ),
              child: Text(
                'NEXT',
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
                const Text('Do not have an account?'),
                const RowSpacer(width: 5),
                GestureDetector(
                  onTap: () {
                    Future.delayed(const Duration(microseconds: 400), () async {
                      Navigator.of(context).pop();
                      await signInGeneralDialogBox(
                          context: context, themeData: themeData);
                    });
                  },
                  child: Text('Sign In',
                      style: TextStyle(
                        color: themeData.colorScheme.onPrimaryContainer,
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
