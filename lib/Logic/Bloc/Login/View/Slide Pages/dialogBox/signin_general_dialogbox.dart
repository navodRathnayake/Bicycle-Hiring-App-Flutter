library signin_general_dialogbox;

import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/Src/otp_code_body.dart';
import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/Src/signin_form_body.dart';
import 'package:final_project/Logic/Bloc/Login/View/Slide%20Pages/loading%20pages/otp_body_loading_page.dart';
import 'package:final_project/Logic/Bloc/Login/auth/forget%20password/confirm%20otp/confirm_otp_bloc.dart';
import 'package:final_project/Logic/Bloc/Login/auth/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

Future<Object?> signInGeneralDialogBox(
    {required BuildContext context, required ThemeData themeData}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: 'Sign In',
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
          child: MultiBlocProvider(
            providers: [
              BlocProvider<RegisterFormBloc>(create: (_) => RegisterFormBloc()),
              BlocProvider<ConfirmOTPBloc>(create: (_) => ConfirmOTPBloc()),
            ],
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
                        BlocBuilder<RegisterFormBloc, RegisterFormState>(
                          builder: (context, state) {
                            if (state.status == FormzSubmissionStatus.initial) {
                              return SizedBox(
                                  height: 580,
                                  child:
                                      OTPLoadingBodyPage() //SigningFormBody(themeData: themeData),
                                  );
                            }
                            if (state.status == FormzSubmissionStatus.success) {
                              return SizedBox(
                                height: 580,
                                child: OTPCodeBody(themeData: themeData),
                              );
                            } else {
                              return Container();
                            }
                          },
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
      );
    },
  );
}
