library row_spacer;

import 'package:flutter/material.dart';

class RowSpacer extends StatelessWidget {
  final double width;
  const RowSpacer({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
