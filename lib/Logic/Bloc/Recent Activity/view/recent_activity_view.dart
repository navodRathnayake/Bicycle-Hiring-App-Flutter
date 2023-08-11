library recent_activity_view.dart;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/recent_activity_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/day_widget.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/recent_activity_app_bar.dart';

import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/recent_activity_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RecentActivityView extends StatelessWidget {
  final List<List> filter;
  final ThemeData themeData;
  const RecentActivityView(
      {super.key, required this.themeData, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 0, top: 25, bottom: 10),
            child: RecentActivityAppBar(
              title: 'Recent Activities',
              themeData: themeData,
            ),
          ),
          const ColumnSpacer(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<RecentActivityBloc, RecentActivityState>(
              builder: (context, state) {
                if (state.status == RecentActivityStatus.inProcess) {
                  return RecentActivityInProcess(themeData: themeData);
                } else if (state.status == RecentActivityStatus.success) {
                  return RecentActivitySuccess(
                      themeData: themeData, filter: filter);
                } else if (state.status == RecentActivityStatus.failure) {
                  return RecentActivityFailure(themeData: themeData);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecentActivityInProcess extends StatelessWidget {
  final ThemeData themeData;
  const RecentActivityInProcess({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ColumnSpacer(height: 30),
        CircularProgressIndicator(),
        ColumnSpacer(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text('Adding Creadit',
              style: TextStyle(
                fontSize: 25,
              )),
        ),
        ColumnSpacer(height: 5),
        Text('Card',
            style: TextStyle(
              fontSize: 25,
            )),
        ColumnSpacer(height: 10),
        Text('It will take a while')
      ],
    );
  }
}

class RecentActivitySuccess extends StatelessWidget {
  final List<List> filter;
  final ThemeData themeData;
  const RecentActivitySuccess(
      {super.key, required this.themeData, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: double.maxFinite,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filter.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    BlocProvider.of<RecentActivityBloc>(context)
                        .add(RecentActivityItemScrollController(index: index));
                  },
                  child: BlocBuilder<RecentActivityBloc, RecentActivityState>(
                    builder: (context, state) {
                      if (state.selectedIndex == index) {
                        return DayWidget(
                          day: filter[index][0],
                          date: filter[index][1],
                          isSelected: true,
                          themeData: themeData,
                        );
                      } else {
                        return DayWidget(
                          day: filter[index][0],
                          date: filter[index][1],
                          isSelected: false,
                          themeData: themeData,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          const ColumnSpacer(height: 20),
          Expanded(
            child: Container(
              color: themeData.colorScheme.secondaryContainer,
              child: ScrollablePositionedList.builder(
                itemScrollController:
                    BlocProvider.of<RecentActivityBloc>(context)
                        .state
                        .itemScrollController,
                itemCount: filter.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        itemBuilder: (sddsd, nested) => filter[index][3] == null
                            ? Expanded(child: Container())
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/recentActivityRoute');
                                },
                                child: RecentActivityTile(
                                  startTime: filter[index][3][nested][2],
                                  endTime: filter[index][3][nested][3],
                                  startLocation: filter[index][3][nested][0],
                                  endLocation: filter[index][3][nested][1],
                                  themeData: themeData,
                                ),
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
    );
  }
}

class RecentActivityFailure extends StatelessWidget {
  final ThemeData themeData;
  const RecentActivityFailure({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ColumnSpacer(height: 10),
          Image.asset('Assets/icons/sad.png',
              color: themeData.colorScheme.onBackground),
          const ColumnSpacer(height: 10),
          const Text('Something',
              style: TextStyle(
                fontSize: 25,
              )),
          const ColumnSpacer(height: 5),
          const Text('Went Wrong',
              style: TextStyle(
                fontSize: 25,
              )),
          const ColumnSpacer(height: 5),
          const Text('Buddy!',
              style: TextStyle(
                fontSize: 25,
              )),
          const ColumnSpacer(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Try again to fill your account with points',
              textAlign: TextAlign.center,
            ),
          ),
          const ColumnSpacer(height: 30),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<RecentActivityBloc>(context)
                  .add(RecentActivityClickedEvent());
            },
            child: const Text('Try Again'),
          )
        ],
      ),
    );
  }
}
