library recent_activity_route_page;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/recent_activity_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/route_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentActivityRoutePage extends StatelessWidget {
  final ThemeData themeData;
  const RecentActivityRoutePage({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return BlocBuilder<RecentActivityBloc, RecentActivityState>(
          builder: (context, state) {
            if (state.routeStatus == RecentActivityRouteStatus.inProcess) {
              return const ActivityRouteInProcess();
            } else if (state.routeStatus == RecentActivityRouteStatus.success) {
              return ActivityRouteSuccess(themeData: themeData);
            } else if (state.routeStatus == RecentActivityRouteStatus.failure) {
              return ActivityRouteFailure(themeData: themeData);
            } else if (state.routeStatus == RecentActivityRouteStatus.cancel) {
              return ActivityRouteCancel(themeData: themeData);
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }
}

class RouteCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String imgUrl;
  final ThemeData themeData;
  const RouteCard({
    super.key,
    required this.color,
    required this.themeData,
    required this.title,
    required this.subtitle,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color.fromARGB(255, 226, 224, 224),
              child: Image.asset(
                imgUrl,
                scale: 2,
              ),
            ),
            const ColumnSpacer(height: 5),
            Text(title, style: themeData.textTheme.bodyLarge),
            const ColumnSpacer(height: 5),
            Text(subtitle, style: themeData.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class RouteBottomCard extends StatelessWidget {
  final ThemeData themeData;
  final String time;
  final double distance;
  const RouteBottomCard({
    super.key,
    required this.themeData,
    required this.time,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.timelapse,
                        color: themeData.colorScheme.secondary),
                    const RowSpacer(width: 5),
                    Text(
                      'Time',
                      style: TextStyle(color: themeData.colorScheme.secondary),
                    ),
                  ],
                ),
                Text(
                  '$time h',
                  style: themeData.textTheme.headlineMedium,
                ),
                Text('$distance Km',
                    style: TextStyle(color: themeData.colorScheme.secondary)),
              ],
            ),
            Image.asset('Assets/icons/route_path.png',
                color: themeData.colorScheme.secondary),
          ],
        ),
      ),
    );
  }
}

class ActivityRouteInProcess extends StatelessWidget {
  const ActivityRouteInProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
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
      ),
    );
  }
}

class ActivityRouteSuccess extends StatelessWidget {
  final ThemeData themeData;
  const ActivityRouteSuccess({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 0, top: 25, bottom: 10),
          child: RoutePageAppBar(
            themeData: themeData,
            startLocation: 'Kandy',
            endLocation: 'Peradeniya',
            date: 12,
            day: 'Mon',
            startTime: '9.00 am',
            endTime: '3.30 pm',
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RouteCard(
                    themeData: themeData,
                    title: '23 °C',
                    subtitle: 'Temp',
                    imgUrl: 'Assets/icons/route_temp.png',
                    color: themeData.colorScheme.secondaryContainer,
                  ),
                  RouteCard(
                    themeData: themeData,
                    title: 'Rs 53.70 /=',
                    subtitle: 'Cost',
                    imgUrl: 'Assets/icons/payment_type.png',
                    color: themeData.colorScheme.secondaryContainer,
                  ),
                  RouteCard(
                    themeData: themeData,
                    title: 'A',
                    subtitle: 'Station',
                    imgUrl: 'Assets/icons/bicycling.png',
                    color: themeData.colorScheme.secondaryContainer,
                  ),
                ],
              ),
            ),
            const ColumnSpacer(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RouteBottomCard(
                themeData: themeData,
                time: '01 : 20 : 05',
                distance: 25.7,
              ),
            ),
            const ColumnSpacer(height: 10),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Back to the Recent Activity',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const ColumnSpacer(height: 10),
          ],
        ),
      ],
    );
  }
}

class ActivityRouteFailure extends StatelessWidget {
  final ThemeData themeData;
  const ActivityRouteFailure({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Center(
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
                // BlocProvider.of<RecentActivityBloc>(context)
                //     .add(RecentActivityClickedEvent());
              },
              child: const Text('Try Again'),
            )
          ],
        ),
      ),
    );
  }
}

class ActivityRouteCancel extends StatelessWidget {
  final ThemeData themeData;
  const ActivityRouteCancel({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Center(
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
              // BlocProvider.of<RecentActivityBloc>(context)
              //     .add(RecentActivityClickedEvent());
            },
            child: const Text('Try Again'),
          )
        ],
      ),
    );
  }
}
