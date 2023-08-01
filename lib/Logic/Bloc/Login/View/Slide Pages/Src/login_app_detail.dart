library login_app_detail;

import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/dialogBox/signin_general_dialogbox.dart';
import 'package:flutter/material.dart';
import '../../../../../../Const/Widget/column_spacer.dart';
import '../../../../../../Const/Widget/row_spacer.dart';

class LoginAppDetail extends StatelessWidget {
  final ThemeData themeData;
  const LoginAppDetail({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 1, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amberAccent,
                    child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'Assets/icons/back.png',
                          scale: 2,
                        )),
                  )
                ],
              ),
              const ColumnSpacer(height: 20),
              Text(
                'Let\'s Sign You in.',
                style: themeData.textTheme.displayMedium,
              ),
              const ColumnSpacer(height: 20),
              Text('Welcome back.', style: themeData.textTheme.displaySmall),
              Text('You\'ve been missed!',
                  style: themeData.textTheme.displaySmall),
            ],
          ),
          Column(
            children: [
              const ColumnSpacer(height: 10),
              Text('HIRE YOUR BICYCLE TODAY!',
                  style: themeData.textTheme.bodyLarge),
              const Text(
                  'This is the demo text. Add a relevant text field here.'),
              const ColumnSpacer(height: 10),
              ElevatedButton(
                  onPressed: () {
                    signInGeneralDialogBox(
                        context: context, themeData: themeData);
                  }, //FirebaseAuthService().signInWithGoogle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('Assets/icons/google.png'),
                        const RowSpacer(width: 5),
                        const Text('Sign Up With Google'),
                        const ColumnSpacer(height: 30),
                      ],
                    ),
                  )),
              const ColumnSpacer(height: 10),
              Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const ColumnSpacer(height: 10),
            ],
          )
        ],
      ),
    );
  }
}
