library info_layout;

import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:flutter/material.dart';

class InfoLayout extends StatelessWidget {
  const InfoLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset('Assets/icons/info.png', scale: 2),
            const RowSpacer(width: 5),
            const Text('Instructions',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
