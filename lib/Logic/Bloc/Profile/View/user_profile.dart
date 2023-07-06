library user_profile;

import 'package:flutter/material.dart';

import 'widget/profile_avater.dart';

class UserProfile extends StatelessWidget {
  final ThemeData themeData;
  const UserProfile({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 0, top: 25, bottom: 10),
        child: Column(
          children: [
            ProfileAvater(themeData: themeData),
          ],
        ),
      ),
    );
  }
}
