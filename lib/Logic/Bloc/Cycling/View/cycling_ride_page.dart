library cycling_ride_page;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Cycling/View/validation_dialog_box.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/qr_scan_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/ride_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/src/get_current_location.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/avatar.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/points.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rolling_switch/rolling_switch.dart';

class CyclingRidePage extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  const CyclingRidePage({super.key, required this.authenticationRepository});

  static Route<void> route(
      {required AuthenticationRepository authenticationRepository}) {
    return MaterialPageRoute<void>(
        builder: (_) => CyclingRidePage(
              authenticationRepository: authenticationRepository,
            ));
  }

  @override
  State<CyclingRidePage> createState() => _CyclingRidePageState();
}

class _CyclingRidePageState extends State<CyclingRidePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Points(themeData: themeData),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Avatar(),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: PopUpSettingsMenu(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context),
                  icon: CustomSettingsIcon(
                    themeData: themeData,
                  ))),
        ],
      ),
      body: BlocBuilder<RideBloc, RideState>(
        builder: (context, state) {
          if (state.status == RideStatus.inProcess) {
            return const CyclingInProcess();
          } else if (state.status == RideStatus.success) {
            return CyclingSuccess(themeData: themeData);
          } else if (state.status == RideStatus.failure) {
            return CyclingFailure(
              themeData: themeData,
              authenticationRepository: widget.authenticationRepository,
            );
          } else {
            return CyclingFailure(
              themeData: themeData,
              authenticationRepository: widget.authenticationRepository,
            );
          }
        },
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ThemeData themeData;
  const InfoCard(
      {super.key,
      required this.themeData,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title),
            const ColumnSpacer(height: 10),
            Text(subtitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}

class CustomToggleWidget extends StatefulWidget {
  const CustomToggleWidget({super.key});

  @override
  State<CustomToggleWidget> createState() => _CustomToggleWidgetState();
}

class _CustomToggleWidgetState extends State<CustomToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return RollingSwitch.icon(
      circularColor: Colors.amber,
      height: 60,
      onChanged: (bool state) {},
      rollingInfoRight: const RollingIconInfo(
        icon: Icons.emergency,
        text: Text('ON'),
        backgroundColor: Colors.amber,
        iconColor: Colors.red,
      ),
      rollingInfoLeft: const RollingIconInfo(
        icon: Icons.check,
        backgroundColor: Colors.white,
        iconColor: Colors.amber,
        text: Text('OFF'),
      ),
    );
  }
}

class LockBikeToggle extends StatefulWidget {
  const LockBikeToggle({super.key});

  @override
  State<LockBikeToggle> createState() => _LockBikeToggleState();
}

class _LockBikeToggleState extends State<LockBikeToggle> {
  @override
  Widget build(BuildContext context) {
    return RollingSwitch.icon(
      circularColor: Colors.amber,
      height: 60,
      onChanged: (bool state) {},
      rollingInfoRight: const RollingIconInfo(
        icon: Icons.emergency,
        text: Text('ON'),
        backgroundColor: Colors.amber,
        iconColor: Colors.red,
      ),
      rollingInfoLeft: const RollingIconInfo(
        icon: Icons.check,
        backgroundColor: Colors.white,
        iconColor: Colors.amber,
        text: Text('OFF'),
      ),
    );
  }
}

class CyclingInProcess extends StatelessWidget {
  const CyclingInProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<RideBloc, RideState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ColumnSpacer(height: 30),
              const CircularProgressIndicator(),
              const ColumnSpacer(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  state.msg.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const ColumnSpacer(height: 5),
              const ColumnSpacer(height: 10),
              const Text('It will take a while'),
            ],
          );
        },
      ),
    );
  }
}

class CyclingSuccess extends StatelessWidget {
  final ThemeData themeData;
  const CyclingSuccess({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ColumnSpacer(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  var serviceEnabled =
                      await Geolocator.isLocationServiceEnabled();
                  if (serviceEnabled) {
                    Navigator.of(context).pushNamed('/mapLauncher');
                  } else {
                    validationDialogBox(
                        context: context,
                        themeData: themeData,
                        msg:
                            'The following device has denied the google location service. Please turn on the location service in your app settings or give the permission to this app.');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('CURRENT LOCATION'),
                            const ColumnSpacer(height: 10),
                            Text(
                              BlocProvider.of<StepperBloc>(context)
                                  .state
                                  .bicycle
                                  .station,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: themeData.colorScheme.onBackground),
                            ),
                            Text(
                              'Station',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: themeData.colorScheme.onBackground),
                            ),
                            const ColumnSpacer(height: 20),
                          ],
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    'Assets/icons/location_on_map.jpg',
                                    scale: 4,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        Colors.blue.shade600.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue.shade700,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'Assets/icons/navigation.png',
                                            scale: 2,
                                            color: themeData
                                                .colorScheme.background,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 330,
                      decoration: BoxDecoration(
                        color: themeData.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 150,
                            backgroundColor: Colors.amber,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('Assets/icons/bicycle_sharing.png'),
                                Text(
                                  'CYCLE',
                                  style: TextStyle(
                                    color: themeData.colorScheme.background,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const ColumnSpacer(height: 10),
                                Text(
                                  'PROFILE',
                                  style: TextStyle(
                                      color: themeData.colorScheme.onBackground,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.red.shade600,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              const ColumnSpacer(height: 20),
                              const CustomToggleWidget(),
                              const ColumnSpacer(height: 10),
                              Text(
                                'EMERGENCY',
                                style: TextStyle(
                                  color: themeData.colorScheme.background,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                'MODE',
                                style: TextStyle(
                                  color: themeData.colorScheme.background,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const Row(),
                            ],
                          ),
                        ),
                        const ColumnSpacer(height: 10),
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: themeData.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'LOCK',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: themeData
                                              .colorScheme.onBackground,
                                        ),
                                      ),
                                      Text(
                                        'your bike',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: themeData
                                              .colorScheme.onBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: SizedBox(
                                  height: 160,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset('Assets/icons/lock.png'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoCard(
                      themeData: themeData,
                      title: 'Usage time',
                      subtitle: '42h 16m'),
                  InfoCard(
                      themeData: themeData,
                      title: 'Usage time',
                      subtitle: '42h 16m'),
                  InfoCard(
                      themeData: themeData,
                      title: 'Usage time',
                      subtitle: '42h 16m'),
                ],
              ),
            ),
            const ColumnSpacer(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'COMPLETE',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class CyclingFailure extends StatelessWidget {
  final ThemeData themeData;
  final AuthenticationRepository authenticationRepository;
  const CyclingFailure(
      {super.key,
      required this.themeData,
      required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: BlocBuilder<RideBloc, RideState>(
        builder: (context, state) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    state.msg.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                const ColumnSpacer(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<QRScanBloc>(context)
                        .add(QRScanRollBackEvent());
                    BlocProvider.of<StepperBloc>(context)
                        .add(StepperRollBackEvent());
                    SqfliteHelper.instance
                        .updateAutherization(status: 'login-verified');
                    authenticationRepository.loading();
                    await Future.delayed(const Duration(milliseconds: 1200));
                    authenticationRepository.verified();
                  },
                  child: const Text('Try Again'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
