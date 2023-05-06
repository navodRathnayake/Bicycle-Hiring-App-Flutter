library splash_activity;

import 'package:flutter/material.dart';

class SplashActivity extends StatelessWidget {
  const SplashActivity({super.key});

  static Route<void> route() => MaterialPageRoute(
        builder: (_) => const SplashActivity(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
