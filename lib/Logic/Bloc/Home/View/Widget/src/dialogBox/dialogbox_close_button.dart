library dialogbox_close_button;

import 'package:flutter/material.dart';

class DialogBoxCloseButton extends StatelessWidget {
  final ThemeData themeData;
  const DialogBoxCloseButton({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          'Assets/icons/close.png',
          color: themeData.colorScheme.secondaryContainer,
          scale: 1.4,
        ),
      ),
    );
  }
}
