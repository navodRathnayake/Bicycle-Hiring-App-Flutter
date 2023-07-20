library auth_controller;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar_controller.dart';

class AuthController extends StatelessWidget {
  const AuthController({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const BottomNavigationBarController();
          } else {
            return const BottomNavigationBarController(); //PageSlider(themeData: themeData);
          }
        },
      ),
    );
  }
}
