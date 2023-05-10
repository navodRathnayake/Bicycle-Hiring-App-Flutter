library points;

import 'package:flutter/material.dart';

import '../../../../../Const/Widget/row_spacer.dart';

class Points extends StatelessWidget {
  const Points({super.key});

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
            children: [
              const Text('1,000'),
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
