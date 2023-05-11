library news_tag_tile;

import 'package:flutter/material.dart';

class NewsTagTile extends StatelessWidget {
  final ThemeData themeData;
  const NewsTagTile({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        child: Icon(Icons.info),
      ),
      title: const Text('This is the title of the news'),
      subtitle: const Text('sub text is here'),
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: themeData.colorScheme.onBackground,
          )),
    );
  }
}
