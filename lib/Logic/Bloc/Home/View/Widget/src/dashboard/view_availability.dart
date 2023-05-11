library view_availability;

import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:flutter/material.dart';

class ViewAvailability extends StatelessWidget {
  const ViewAvailability({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset('Assets/icons/bicycle.png', scale: 2),
            const RowSpacer(width: 5),
            const Text('Availability',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
