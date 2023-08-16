library profile_info;

import 'package:final_project/Autheriztion/autherization_bloc.dart';
import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<Object?> profileInfoDialogBox(
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
                          BlocBuilder<AutherizationBloc, AutherizationState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 580,
                                child: Center(
                                  child: Column(
                                    children: [
                                      ColumnSpacer(height: 30),
                                      const Text('USER',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      const Text('ACCOUNT',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 5)),
                                      const ColumnSpacer(height: 30),
                                      Text(
                                        state.user!.userName.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                      const ColumnSpacer(height: 30),
                                      Text(state.user!.email.toString()),
                                      const ColumnSpacer(height: 30),
                                      Text(state.user!.nic.toString()),
                                      const ColumnSpacer(height: 30),
                                      Text(state.user!.bloodGroup.toString()),
                                      const ColumnSpacer(height: 30),
                                      SizedBox(
                                        width: 120,
                                        child: Points(
                                            themeData: themeData,
                                            points:
                                                state.user!.points.toString()),
                                      ),
                                    ],
                                  ),
                                ),
                              );
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
        ),
      );
    },
  );
}
