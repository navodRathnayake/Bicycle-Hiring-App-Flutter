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
                } else if (state.status == RecentActivityStatus.empty) {
                  return REcentActivityEmpty(themeData: themeData);
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
    return BlocBuilder<RecentActivityBloc, RecentActivityState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: double.maxFinite,
                child: BlocBuilder<RecentActivityBloc, RecentActivityState>(
                  builder: (context, state) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.activities.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            BlocProvider.of<RecentActivityBloc>(context).add(
                                RecentActivityItemScrollController(
                                    index: index));
                          },
                          child: BlocBuilder<RecentActivityBloc,
                              RecentActivityState>(
                            builder: (context, state) {
                              if (state.selectedIndex == index) {
                                return DayWidget(
                                  day: state.activities[index][1]
                                      .toString()
                                      .substring(0, 3),
                                  date: int.parse(
                                      state.activities[index][0].toString()),
                                  isSelected: true,
                                  themeData: themeData,
                                );
                              } else {
                                return DayWidget(
                                  day: state.activities[index][1]
                                      .toString()
                                      .substring(0, 3),
                                  date: int.parse(
                                      state.activities[index][0].toString()),
                                  isSelected: false,
                                  themeData: themeData,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
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
                    itemCount: state.activities.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: DayWidget(
                                  day: state.activities[index][1]
                                      .toString()
                                      .substring(0, 3),
                                  date: int.parse(
                                      state.activities[index][0].toString()),
                                  isSelected: false,
                                  themeData: themeData),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: int.parse(
                                state.activities[index][2].length.toString()),
                            shrinkWrap: true,
                            itemBuilder: (nestedContext, nested) => int.parse(
                                        state.activities[index][2].length
                                            .toString()) ==
                                    0
                                ? Expanded(child: Container())
                                : GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<RecentActivityBloc>(
                                              context)
                                          .add(RecentAcrivityViewEvent(
                                        index: index,
                                        nested: nested,
                                      ));
                                      Navigator.of(context)
                                          .pushNamed('/recentActivityRoute');
                                    },
                                    child: RecentActivityTile(
                                      startTime: state.activities[index][1],
                                      endTime:
                                          state.activities[index][0].toString(),
                                      startLocation:
                                          state.activities[index][0].toString(),
                                      endLocation:
                                          state.activities[index][1].toString(),
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
      },
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

class REcentActivityEmpty extends StatelessWidget {
  final ThemeData themeData;
  const REcentActivityEmpty({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ColumnSpacer(height: 10),
        Image.asset('Assets/icons/sad.png',
            color: themeData.colorScheme.onBackground),
        const ColumnSpacer(height: 10),
        const Text('Activities',
            style: TextStyle(
              fontSize: 25,
            )),
        const ColumnSpacer(height: 5),
        const Text('Were Not',
            style: TextStyle(
              fontSize: 25,
            )),
        const ColumnSpacer(height: 5),
        const Text('Found!!',
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
    );
  }
}
