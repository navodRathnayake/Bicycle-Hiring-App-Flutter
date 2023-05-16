library dialogbox_ok_button;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBoxOkButton extends StatelessWidget {
  final String label;
  final Function onTap;
  const DialogBoxOkButton(
      {super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(label,
              style: GoogleFonts.ubuntu(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
