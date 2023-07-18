library auth_controller;

import 'package:final_project/Logic/Bloc/Login/View/page_slider.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/recent_activity_page.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/recent_activity_view.dart';
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
            return RecentActivityPage(
              themeData: themeData,
            ); //const BottomNavigationBarController();
          } else {
            return PageSlider(themeData: themeData);
          }
        },
      ),
    );
  }
}
