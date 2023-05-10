library app_message_content;

import 'package:flutter/material.dart';

class AppMessageContent extends StatelessWidget {
  final String content;
  const AppMessageContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          content,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
