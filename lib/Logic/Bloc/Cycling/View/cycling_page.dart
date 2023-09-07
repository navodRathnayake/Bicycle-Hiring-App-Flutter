library cycling_page;

import 'package:final_project/Account/account_bloc.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Cycling/View/modal%20bottom%20sheets/qr_model_bottom_sheet.dart';
import 'package:final_project/Logic/Bloc/Cycling/View/validation_dialog_box.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/ride_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/src/validate_location.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/avatar.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/points.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CyclingPage extends StatelessWidget {
  final ThemeData themeData;
  const CyclingPage({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScanQRView(themeData: themeData),
        ],
      ),
    );
  }
}

class ScanQRView extends StatelessWidget {
  final ThemeData themeData;
  const ScanQRView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const ColumnSpacer(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      'Assets/icons/qr.png',
                      color: themeData.colorScheme.onBackground,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 33,
                          backgroundColor: themeData.colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: themeData.colorScheme.secondary,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'Assets/icons/activities.png',
                                  scale: 1,
                                  color: themeData.colorScheme.background,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Assets/icons/c.png',
                    scale: 2,
                    color: themeData.colorScheme.primary,
                  ),
                  const RowSpacer(width: 10),
                  Text('RideSafe.org', style: themeData.textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Scan QR code to unlock your service bicycle to ride. Follow few steps to confirm and padal to the destination.',
                  textAlign: TextAlign.center,
                ),
              ),
              const ColumnSpacer(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    var response = await getCurrentLocation();
                    debugPrint(response.toString());

                    debugPrint('Latitude : ${response.latitude}');
                    debugPrint('Langatude : ${response.longitude}');

                    Map<String, dynamic> validateResult = isValidLocation(
                        lang: response.latitude.toString(),
                        long: response.longitude.toString(),
                        stations: stations);

                    debugPrint(validateResult.toString());

                    String msg = '';

                    if (validateResult['validate']) {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<RideBloc>(context).add(
                          RideStartLocationDataEvent(
                              startLang: response.latitude.toString(),
                              startLong: response.longitude.toString(),
                              startLocation: validateResult['station']));
                      if (BlocProvider.of<AccountBloc>(context)
                              .state
                              .user
                              .points >
                          packagePool['min30']!) {
                        // ignore: use_build_context_synchronously
                        qrModalBottomSheet(
                            context: context, themeData: themeData);
                      } else {
                        msg =
                            'The account balance has less minimum points to get the relevent service. Please fulfill your account with creadits';
                        // ignore: use_build_context_synchronously
                        validationDialogBox(
                            context: context, themeData: themeData, msg: msg);
                      }
                    } else {
                      msg =
                          'The following access location has identifyied as fake. Try again to access the relevant bicycle being at correct location';
                      // ignore: use_build_context_synchronously
                      validationDialogBox(
                          context: context, themeData: themeData, msg: msg);
                    }

                    // qrModalBottomSheet(context: context, themeData: themeData);

                    // Navigator.of(context).pushNamed('/cyclingStepperPage');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Center(
                          child: Text(
                        'Tap to scan QR for unlock your bicycle',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
