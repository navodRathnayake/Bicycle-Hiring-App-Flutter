library bottom_navigation_bar_controller;

import 'package:final_project/Logic/Bloc/Cycling/View/cycling_page.dart';
import 'package:final_project/Logic/Bloc/Home/View/home_page.dart';
import 'package:final_project/Logic/Bloc/Profile/View/user_profile.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarController extends StatefulWidget {
  const BottomNavigationBarController({super.key});

  @override
  State<BottomNavigationBarController> createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: [
        HomePage(themeData: themeData),
        UserProfile(themeData: themeData),
        CyclingPage(themeData: themeData),
      ][currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(50),
          ),
          child: NavigationBar(
            destinations: [
              NavigationDestination(
                  icon: Image.asset('Assets/icons/home.png',
                      color: themeData.colorScheme.secondary),
                  label: 'Home'),
              NavigationDestination(
                  icon: Image.asset('Assets/icons/cycling.png',
                      color: themeData.colorScheme.secondary),
                  label: 'Cycling'),
              NavigationDestination(
                  icon: Image.asset('Assets/icons/profile.png',
                      color: themeData.colorScheme.secondary),
                  label: 'Profile'),
              NavigationDestination(
                  icon: Image.asset('Assets/icons/qr.png',
                      color: themeData.colorScheme.secondary, scale: 1.4),
                  label: 'QR'),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedIndex: currentIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (value) {
              setState(() {
                currentIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
