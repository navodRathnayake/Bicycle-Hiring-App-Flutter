library pin_code_intergration;

import 'package:final_project/Logic/Bloc/Profile/View/widget/pin_code_intergration_body.dart';
import 'package:flutter/material.dart';

Future<Object?> pinCodeIntergration(
    {required BuildContext context, required ThemeData themeData}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: 'Pin Code',
    context: context,
    transitionDuration: const Duration(milliseconds: 800),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) {
      return Center(
        child: Container(
          height: 600,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: -30,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            child: Image.asset(
                              'Assets/icons/close.png',
                              scale: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 580,
                        child: PinCodeIntergrationBody(themeData: themeData),
                      ),
                      // SigningFormBody(themeData: themeData),
                      // LoginFormBody(themeData: themeData),
                      // OTPCodeBody(themeData: themeData),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
