library recent_activity_route_page;

import 'dart:async';

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/recent_activity_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/route_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecentActivityRoutePage extends StatefulWidget {
  final ThemeData themeData;
  const RecentActivityRoutePage({super.key, required this.themeData});

  @override
  State<RecentActivityRoutePage> createState() =>
      _RecentActivityRoutePageState();
}

class _RecentActivityRoutePageState extends State<RecentActivityRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return BlocBuilder<RecentActivityBloc, RecentActivityState>(
            builder: (context, state) {
              if (state.routeStatus == RecentActivityRouteStatus.inProcess) {
                return const ActivityRouteInProcess();
              } else if (state.routeStatus ==
                  RecentActivityRouteStatus.success) {
                return ActivityRouteSuccess(themeData: widget.themeData);
              } else if (state.routeStatus ==
                  RecentActivityRouteStatus.failure) {
                return ActivityRouteFailure(themeData: widget.themeData);
              } else if (state.routeStatus ==
                  RecentActivityRouteStatus.cancel) {
                return ActivityRouteCancel(themeData: widget.themeData);
              } else {
                return Container();
              }
            },
          );
        }),
      ),
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

class ActivityRouteInProcess extends StatefulWidget {
  const ActivityRouteInProcess({super.key});

  @override
  State<ActivityRouteInProcess> createState() => _ActivityRouteInProcessState();
}

class _ActivityRouteInProcessState extends State<ActivityRouteInProcess> {
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

class ActivityRouteSuccess extends StatefulWidget {
  final ThemeData themeData;
  const ActivityRouteSuccess({super.key, required this.themeData});

  @override
  State<ActivityRouteSuccess> createState() => _ActivityRouteSuccessState();
}

class _ActivityRouteSuccessState extends State<ActivityRouteSuccess> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapDrawer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10),
              child: RoutePageAppBar(
                themeData: widget.themeData,
                startLocation: BlocProvider.of<RecentActivityBloc>(context)
                    .state
                    .tempActivityDetails['path']['startLocation']
                    .toString(),
                endLocation: BlocProvider.of<RecentActivityBloc>(context)
                    .state
                    .tempActivityDetails['path']['endLocation']
                    .toString(),
                date: 1,
                day: BlocProvider.of<RecentActivityBloc>(context)
                    .state
                    .tempActivityDetails['date']
                    .toString(),
                startTime: BlocProvider.of<RecentActivityBloc>(context)
                    .state
                    .tempActivityDetails['startTime']
                    .toString(),
                endTime: BlocProvider.of<RecentActivityBloc>(context)
                    .state
                    .tempActivityDetails['endTime']
                    .toString(),
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
                        themeData: widget.themeData,
                        title: '23 °C',
                        subtitle: 'Temp',
                        imgUrl: 'Assets/icons/route_temp.png',
                        color: widget.themeData.colorScheme.secondaryContainer,
                      ),
                      RouteCard(
                        themeData: widget.themeData,
                        title:
                            'Rs ${BlocProvider.of<RecentActivityBloc>(context).state.tempActivityDetails['amount'].toString()} /=',
                        subtitle: 'Cost',
                        imgUrl: 'Assets/icons/payment_type.png',
                        color: widget.themeData.colorScheme.secondaryContainer,
                      ),
                      RouteCard(
                        themeData: widget.themeData,
                        title: 'A',
                        subtitle: 'Station',
                        imgUrl: 'Assets/icons/bicycling.png',
                        color: widget.themeData.colorScheme.secondaryContainer,
                      ),
                    ],
                  ),
                ),
                const ColumnSpacer(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: RouteBottomCard(
                    themeData: widget.themeData,
                    time: timeDuration(
                        startTime: BlocProvider.of<RecentActivityBloc>(context)
                            .state
                            .tempActivityDetails['startTime']
                            .toString(),
                        endTime: BlocProvider.of<RecentActivityBloc>(context)
                            .state
                            .tempActivityDetails['endTime']
                            .toString()),
                    distance: double.parse(
                        BlocProvider.of<RecentActivityBloc>(context)
                            .state
                            .tempActivityDetails['path']['distance']
                            .toString()),
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
        ),
      ],
    );
  }
}

class MapDrawer extends StatefulWidget {
  const MapDrawer({super.key});

  @override
  State<MapDrawer> createState() => MapDrawerState();
}

class MapDrawerState extends State<MapDrawer> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.084048, 80.009831),
    zoom: 14.4746,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    debugPrint('Hello Map this is the location from state');
    debugPrint(BlocProvider.of<RecentActivityBloc>(context)
        .state
        .gpsPoints[0]
        .toString());
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: BlocProvider.of<RecentActivityBloc>(context).state.gpsPoints[0],
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      polylines: {
        Polyline(
          polylineId: const PolylineId('map_routes'),
          points: BlocProvider.of<RecentActivityBloc>(context).state.gpsPoints,
          width: 3,
          color: Colors.green,
        ),
      },
      markers: {
        Marker(
            markerId: const MarkerId('start_point'),
            infoWindow: const InfoWindow(title: 'Start Location'),
            icon: BitmapDescriptor.defaultMarker,
            position: BlocProvider.of<RecentActivityBloc>(context)
                .state
                .gpsPoints[0]),
        Marker(
            markerId: const MarkerId('end_point'),
            infoWindow: const InfoWindow(title: 'end Location'),
            icon: BitmapDescriptor.defaultMarker,
            position: BlocProvider.of<RecentActivityBloc>(context)
                .state
                .gpsPoints
                .last)
      },
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
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

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

String timeDuration({required String endTime, required String startTime}) {
  DateTime dateTime1 = DateTime.parse("2023-11-02 $endTime");
  DateTime dateTime2 = DateTime.parse("2023-11-02 $startTime");

  Duration difference = dateTime2.difference(dateTime1);

  String time3 = difference.toString().split(".")[0]; // result will be 00:48:48

  return time3.toString();
}
