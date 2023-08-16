library points;

import 'package:flutter/material.dart';

import '../../../../../Const/Widget/row_spacer.dart';

class Points extends StatelessWidget {
  final String points;
  final ThemeData themeData;
  const Points({super.key, required this.themeData, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(points, style: const TextStyle(color: Colors.black)),
              const RowSpacer(width: 5),
              Image.asset(
                'Assets/icons/points.png',
                scale: 2,
              )
            ],
          ),
        ));
  }
}
