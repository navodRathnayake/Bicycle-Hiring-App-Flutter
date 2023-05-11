library rounded_layout;

import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:flutter/material.dart';

class RoundedLayout extends StatelessWidget {
  final double spacerWidth = 30;
  final ThemeData themeData;
  const RoundedLayout({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Column(
              children: const [
                Text('WED'),
                Text('6 June'),
              ],
            ),
            RowSpacer(width: spacerWidth),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.sunny),
                Text('Sunny'),
              ],
            ),
            RowSpacer(width: spacerWidth),
            const Text('26°C'),
            RowSpacer(width: spacerWidth),
            const Icon(Icons.air),
            const Text('44Km/h')
          ],
        ),
      ),
    );
  }
}
