library view_availability;

import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:flutter/material.dart';

import '../../availability_dialog_box.dart';

class ViewAvailability extends StatelessWidget {
  final ThemeData themeData;
  const ViewAvailability({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          availabilityDialogBox(context: context, themeData: themeData),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
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
      ),
    );
  }
}
