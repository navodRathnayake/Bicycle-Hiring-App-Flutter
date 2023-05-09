library page_slider;

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'Slide Pages/initial_page.dart';
import 'Slide Pages/login_page.dart';

class PageSlider extends StatelessWidget {
  final ThemeData themeData;
  const PageSlider({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
          Container(color: Colors.amber, child: const InitialPage()),
          LoginPage(
            themeData: themeData,
          )
        ],
      ),
    );
  }
}
