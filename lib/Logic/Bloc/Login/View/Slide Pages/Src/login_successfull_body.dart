library login_succesfull_body;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:flutter/material.dart';

class LoginSuccessFullBody extends StatelessWidget {
  final ThemeData themeData;
  const LoginSuccessFullBody({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const ColumnSpacer(height: 50),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.blue.shade100,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue.shade200,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue.shade700,
                  child: Image.asset('Assets/icons/correct.png',
                      scale: 2, color: Colors.white),
                ),
              ),
            ),
            const ColumnSpacer(height: 30),
            const Text('REGISTERED',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 10)),
            Text('SUCCESSFULLY',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 10,
                    color: Colors.green.shade300)),
            const ColumnSpacer(height: 30),
            Text(useLicense, textAlign: TextAlign.center),
          ],
        ),
        Column(
          children: [
            const Text('Before you register, please refer'),
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
