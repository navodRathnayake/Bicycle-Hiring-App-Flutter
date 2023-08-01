library bloc_layout;

import 'package:flutter/material.dart';

import '../../../../../../../Const/Widget/row_spacer.dart';

class BlocLayout extends StatelessWidget {
  final ThemeData themeData;
  const BlocLayout({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text('Rs', style: themeData.textTheme.labelLarge),
                const RowSpacer(width: 5),
                Text('0.81/=', style: themeData.textTheme.headlineMedium),
              ]),
              const Column(
                children: [
                  Text('Hourly Rate'),
                  Text('more packages'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
