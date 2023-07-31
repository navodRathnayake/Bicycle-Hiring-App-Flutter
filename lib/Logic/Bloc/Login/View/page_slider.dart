library page_slider;

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'Slide Pages/initial_page.dart';
import 'Slide Pages/login_page.dart';

class PageSlider extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PageSlider());
  }

  const PageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
          Container(color: Colors.amber, child: const InitialPage()),
          LoginPage(
            themeData: Theme.of(context),
          )
        ],
      ),
    );
  }
}
