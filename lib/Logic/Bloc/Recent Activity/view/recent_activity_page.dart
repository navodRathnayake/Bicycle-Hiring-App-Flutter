library ercent_activity_page;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/recent_activity_app_bar.dart';
import 'package:flutter/material.dart';

class RecentActivityPage extends StatelessWidget {
  final ThemeData themeData;
  const RecentActivityPage({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 0, top: 25, bottom: 10),
              child: RecentActivityAppBar(
                themeData: themeData,
              ),
            ),
            const ColumnSpacer(height: 10),
          ],
        ),
      ),
    );
  }
}
