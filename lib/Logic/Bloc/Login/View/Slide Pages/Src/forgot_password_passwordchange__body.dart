library forgot_passwordchange_body;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:flutter/material.dart';

class ForgotPasswordChangeBody extends StatelessWidget {
  final ThemeData themeData;
  final FocusNode otp1 = FocusNode();
  final FocusNode otp2 = FocusNode();
  final FocusNode otp3 = FocusNode();
  final FocusNode otp4 = FocusNode();
  ForgotPasswordChangeBody({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Positioned(
              top: 15,
              left: 10,
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'Assets/icons/back_ios.png',
                  scale: 1.5,
                ),
              ),
            ),
            const Column(
              children: [
                ColumnSpacer(height: 10),
                Text(
                  'Change',
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
                    hintText: 'Password',
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Image.asset(
                      'Assets/icons/password.png',
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
                    hintText: 'Confirm Password',
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
                ),
                const ColumnSpacer(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        focusNode: otp1,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            FocusScope.of(context).requestFocus(otp2);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
                        focusNode: otp2,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            FocusScope.of(context).requestFocus(otp3);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
                        focusNode: otp3,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            FocusScope.of(context).requestFocus(otp4);
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
                        focusNode: otp4,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
                'RESET',
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
                const Text('Do you need to create new an account?'),
                const RowSpacer(width: 5),
                GestureDetector(
                  onTap: () {},
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
