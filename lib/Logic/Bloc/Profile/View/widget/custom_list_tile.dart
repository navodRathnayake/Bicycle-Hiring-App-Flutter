library custom_list_tile;

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final ThemeData themeData;
  final String url;
  final String title;
  const CustomListTile(
      {super.key,
      required this.themeData,
      required this.url,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            url,
            scale: 2,
            color: themeData.colorScheme.onSecondaryContainer,
          ),
        ),
      ),
      title: Text(title),
      trailing: Image.asset(
        color: themeData.colorScheme.onSecondaryContainer,
        'Assets/icons/forward.png',
        scale: 2,
      ),
      onTap: () {},
    );
  }
}
