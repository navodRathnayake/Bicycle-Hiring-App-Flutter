library column_spacer;

import 'package:flutter/material.dart';

@immutable
class ColumnSpacer extends StatelessWidget {
  final double height;
  const ColumnSpacer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
