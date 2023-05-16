library dialogbox_secondary_button;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBoxSecondaryButton extends StatelessWidget {
  final ThemeData themeData;
  final String label;
  final Function onTap;
  const DialogBoxSecondaryButton({
    super.key,
    required this.themeData,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.secondaryContainer,
          border: Border.all(
              color: themeData.colorScheme.onSecondaryContainer, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(label,
              style: GoogleFonts.ubuntu(
                color: themeData.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
