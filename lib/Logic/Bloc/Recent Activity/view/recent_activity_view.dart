library recent_activity_view.dart;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/day_widget.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/recent_activity_app_bar.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/recent_activity_tile.dart';
import 'package:flutter/material.dart';

class RecentActivityView extends StatelessWidget {
  final List<List> filter;
  final ThemeData themeData;
  const RecentActivityView(
      {super.key, required this.themeData, required this.filter});

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
              child: RecentActivityAppBar(themeData: themeData),
            ),
            const ColumnSpacer(
              height: 10,
            ),
            Container(
              height: 100,
              width: double.maxFinite,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filter.length,
                  itemBuilder: (context, index) => DayWidget(
                    day: filter[index][0],
                    date: filter[index][1],
                    isSelected: filter[index][2],
                    themeData: themeData,
                  ),
                ),
              ),
            ),
            const ColumnSpacer(height: 20),
            Expanded(
              child: Container(
                color: themeData.colorScheme.secondaryContainer,
                child: ListView.builder(
                  itemCount: filter.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DayWidget(
                                day: filter[index][0],
                                date: filter[index][1],
                                isSelected: filter[index][2],
                                themeData: themeData),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filter[index][3] == null
                              ? 0
                              : filter[index][3].length,
                          shrinkWrap: true,
                          itemBuilder: (sddsd, nested) => filter[index][3] ==
                                  null
                              ? Expanded(child: Container())
                              : RecentActivityTile(
                                  startTime: filter[index][3][nested][2],
                                  endTime: filter[index][3][nested][3],
                                  startLocation: filter[index][3][nested][0],
                                  endLocation: filter[index][3][nested][1],
                                  themeData: themeData,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
