library pin_code_intergration;

import 'package:final_project/Logic/Bloc/Profile/View/widget/pin_code_intergration_body.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/pin_code_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
            body: SingleChildScrollView(
              child: SizedBox(
                height: 600,
                child: Column(
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
                            child:
                                BlocBuilder<PinCodeFormBloc, PinCodeFormState>(
                              builder: (context, state) {
                                if (state.status ==
                                    FormzSubmissionStatus.initial) {
                                  return PinCodeIntergrationBody(
                                      themeData: themeData);
                                } else if (state.status ==
                                    FormzSubmissionStatus.inProgress) {
                                  return const PinCodeIntergrationBodyInProcess();
                                } else if (state.status ==
                                    FormzSubmissionStatus.success) {
                                  return PinCodeIntergrationBodySuccess(
                                      themeData: themeData);
                                } else if (state.status ==
                                    FormzSubmissionStatus.failure) {
                                  return PinCodeIntergrationBodyFailure(
                                      themeData: themeData);
                                } else {
                                  return Container();
                                }
                              },
                            ),
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
          ),
        ),
      );
    },
  );
}
