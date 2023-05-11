library breaker;

import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:flutter/material.dart';

class Breaker extends StatelessWidget {
  const Breaker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          baseWidget(width: 80),
          const RowSpacer(width: 5),
          baseWidget(width: 40),
          const RowSpacer(width: 5),
          baseWidget(width: 30)
        ],
      ),
    );
  }
}

Widget baseWidget({required double width}) {
  return Container(
    width: width,
    height: 5,
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
