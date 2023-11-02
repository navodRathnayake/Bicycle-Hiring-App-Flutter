import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/qr_scan_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/bicycle_patch_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/path_patch_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/path_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/recent_activity_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/service_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/transaction_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/bicycle_patch_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/path_patch_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/path_post_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/recent_activity_post_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/service_post_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/transaction_post_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/model/bicycle_model.dart';
import 'package:final_project/Logic/Bloc/Cycling/src/validate_location.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/model/user_model.dart';
import 'package:final_project/Services/account%20repository/account_repository.dart';
import 'package:final_project/Services/data/data%20provider/user_update_patch_api.dart';
import 'package:final_project/Services/data/repository%20provider/user_update_patch_repository.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:final_project/Services/push%20notification/push_notification_healper_class.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../data/data provider/service_delete_api.dart';
import '../data/repository provider/service_delete_repository.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final AccountStreamRepository accountStreamRepository;
  final AuthenticationRepository authenticationRepository;
  final StepperBloc stepperBloc;
  final QRScanBloc qrScanBloc;
  RideBloc({
    required this.accountStreamRepository,
    required this.authenticationRepository,
    required this.stepperBloc,
    required this.qrScanBloc,
  }) : super(const RideState()) {
    on<RideInitialEvent>(_onRideInitial);
    on<RideLockPressedEvent>(_onRideLockPressed);
    on<RideMapLauncherOnPressedEvent>(_onRideMapLauncherOnPressed);
    on<RideMapRollBackOnPressedEvent>(_onRideMapRollBackOnPressed);
    on<RideCompleteOnPressedEvent>(_onRideCompleteOnPressed);
    on<RideStartLocationDataEvent>(_onRideStartLocation);
    on<RideEndLocationDataEvent>(_onRideEndLocation);
    on<RideDescriptionOnChanged>(_onRideDescriptionOnChanged);
    on<RideEmergencyIDChanged>(_onRideEmergencyIDChanged);
  }

  Future<void> _onRideInitial(
    RideInitialEvent event,
    Emitter<RideState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: RideStatus.inProcess, msg: 'Validating Payment'));
      await Future.delayed(const Duration(milliseconds: 1200));
      debugPrint(event.user.email.toString());
      debugPrint('----------------------------------------');
      debugPrint(event.user.toString());
      debugPrint('----------------------------------------');

      debugPrint('CURRENT PACKAGE : ${event.package}');

      // Bicycle configiration
      var geolocatorResponse = await getCurrentLocation();
      debugPrint(geolocatorResponse.toString());

      Map<String, dynamic> validateResult = isValidLocation(
          lang: geolocatorResponse.latitude.toString(),
          long: geolocatorResponse.longitude.toString(),
          stations: stations);

      debugPrint(validateResult.toString());
      if (validateResult['validate']) {
        debugPrint('LOCATION VALIDATION : PASS');
        if (_validatePayment(
            currentPackage: event.package, balance: event.user.points)) {
          // process
          debugPrint('PAYMENT Validation : PASS');
          await Future.delayed(const Duration(milliseconds: 1200));
          emit(state.copyWith(msg: 'Payment being process'));
          debugPrint('msg : ${state.msg}');

          double newBalance = event.user.points -
              double.parse(_getAmount(currentPackage: event.package));

          debugPrint('New Balance : $newBalance');

          var userUpdatePatch =
              await UserUpdatePatchRepository(api: UserUpdatePatchApi())
                  .getPatchUpdateRepository(
                      reqBody: {"points": newBalance.toString()});
          debugPrint('USER PATCH RESPONSE $userUpdatePatch');

          if (userUpdatePatch['result'] == 1) {
            debugPrint('User update successfully');

            var transactionResponse =
                await TransactionPostRepository(api: TransactionPostApi())
                    .postTransaction(
                        amount: _getAmount(currentPackage: event.package),
                        transactionType: transactionTypeCycling.toString());
            debugPrint(transactionResponse.toString());

            await Future.delayed(const Duration(milliseconds: 1200));

            emit(state.copyWith(
              msg: 'Bicycle Configuration',
            ));
            // task
            String amount = _getAmount(currentPackage: event.package);
            debugPrint('PAYMENT HAS COMPLETED');
            PushNotificationHealperClass().showNotification(
              title: 'Payment Notification',
              body:
                  'You have charged $amount for relevant ${event.package} package',
            );
            await accountStreamRepository.streamIn();
            Future.delayed(const Duration(milliseconds: 1200));
            await accountStreamRepository.streamIdel();
            //table creations
            var tableConfigurationResponse = await _tableConfiguration(
              bicycleID: event.bicycle.bicycleID,
              lang: geolocatorResponse.latitude.toString(),
              long: geolocatorResponse.longitude.toString(),
              station: validateResult['station']!,
              amount: double.parse(_getAmount(currentPackage: event.package))
                  .toString(),
              stationID: validateResult['id'],
            );
            if (tableConfigurationResponse['result'] == 1) {
              emit(state.copyWith(
                msg: 'Bicycle Configuration\nHas Done',
                pathID: tableConfigurationResponse['pathID'],
              ));
              await SqfliteHelper.instance
                  .updateAutherization(status: 'on-service');
              emit(state.copyWith(status: RideStatus.success));
              PushNotificationHealperClass().showNotification(
                title: 'Configuration has success',
                body:
                    'The configuration process has successfully completed. Ride your bicycle to reach your destination today safely!',
              );
            } else {
              _refillAccount(currentPackage: event.package);
              PushNotificationHealperClass().showNotification(
                title: 'Configuration Process Failure',
                body:
                    'The configuration process failed while configuring hardware. Your account has successfully fullfill with your creadits. Try again and reach your destination',
              );
              throw Exception(
                  'The Bicycle Configuration process may have failure');
            }
          } else {
            emit(state.copyWith(
              msg: 'Payment Process Has\nBeen Failed',
              status: RideStatus.failure,
            ));

            throw Exception('Payment Process Has\nBeen Failed');
          }
          // process
        } else {
          debugPrint('PAYMENT VALIDATION : FAIL');
          debugPrint('USER HAS NOT VALIDATED FOR THE PAYMENT');

          emit(state.copyWith(
            msg: 'USER HAS NOT VALIDATED FOR THE PAYMENT',
            status: RideStatus.failure,
          ));

          throw Exception(
              'The account balance has less minimum points to get the relevent service. Please fulfill your account with creadits');
        }
      } else {
        debugPrint('LOCATION VALIDATION : PASS');
        throw Exception('Access Location has denied!');
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        msg: e.toString(),
        status: RideStatus.failure,
      ));
    }
  }

  Future<void> _onRideLockPressed(
    RideLockPressedEvent event,
    Emitter<RideState> emit,
  ) async {
    try {
      if (state.lockStatus == LockStatus.lock) {
        emit(state.copyWith(
          lockStatus: LockStatus.inProcess,
        ));
        await Future.delayed(const Duration(milliseconds: 1200));
        var bicycleUnlockResponse =
            await BicyclePatchRepository(api: BicyclePatchApi()).bicyclePatch(
                bicycleID: event.bicycle.bicycleID, bicycleStatus: '2');

        if (bicycleUnlockResponse['result'] == 1) {
          debugPrint(bicycleUnlockResponse.toString());
          debugPrint('Bicycle has unlocked!');
          emit(state.copyWith(
            lockStatus: LockStatus.unlock,
          ));
        } else {
          debugPrint('LOCK ALERT : CANNOT UNLOCK');
          emit(state.copyWith(
            lockStatus: LockStatus.lock,
          ));
        }
      } else if (state.lockStatus == LockStatus.unlock) {
        emit(state.copyWith(
          lockStatus: LockStatus.inProcess,
        ));
        await Future.delayed(const Duration(milliseconds: 1200));
        var bicycleLockResponse =
            await BicyclePatchRepository(api: BicyclePatchApi()).bicyclePatch(
                bicycleID: event.bicycle.bicycleID, bicycleStatus: '3');
        if (bicycleLockResponse['result'] == 1) {
          debugPrint(bicycleLockResponse.toString());
          debugPrint('bicycle has locked!');
          emit(state.copyWith(
            lockStatus: LockStatus.lock,
          ));
        } else {
          debugPrint('LOCK ALERT : CANNOT LOCK');
          emit(state.copyWith(
            lockStatus: LockStatus.unlock,
          ));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onRideMapLauncherOnPressed(
    RideMapLauncherOnPressedEvent event,
    Emitter<RideState> emit,
  ) async {
    emit(state.copyWith(
      status: RideStatus.inProcess,
      msg: 'Finding Routes',
    ));
    await Future.delayed(const Duration(milliseconds: 1200));
    emit(state.copyWith(status: RideStatus.map));
  }

  Future<void> _onRideMapRollBackOnPressed(
    RideMapRollBackOnPressedEvent event,
    Emitter<RideState> emit,
  ) async {
    emit(state.copyWith(status: RideStatus.inProcess, msg: 'Finding Routes'));
    await Future.delayed(const Duration(milliseconds: 1200));
    emit(state.copyWith(status: RideStatus.success));
  }

  Future<void> _onRideCompleteOnPressed(
    RideCompleteOnPressedEvent event,
    Emitter<RideState> emit,
  ) async {
    emit(state.copyWith(
        status: RideStatus.inProcess, msg: 'Route Completion\nProcess'));
    await Future.delayed(const Duration(milliseconds: 1200));

    try {
      emit(state.copyWith(
          completeStatus: CompleteStatus.initial, msg: 'Configuring Routes'));
      debugPrint(DateTime.now().toString());

      DateTime regDate = DateTime.parse(event.date);
      DateTime completedDate = DateTime.parse(DateTime.now().toString());

      await Future.delayed(const Duration(milliseconds: 1200));

      Duration difference = completedDate.difference(regDate);

      if (difference.inMinutes <
          _getPackagetime(currentPackage: event.package)) {
      } else {
        debugPrint('User did not complete the service on time');

        await Future.delayed(const Duration(milliseconds: 1200));

        emit(state.copyWith(msg: 'Charging Procedure'));

        await Future.delayed(const Duration(milliseconds: 1200));

        ///
        double newBalance =
            event.user.points - double.parse(difference.toString());

        debugPrint('New Time based Balance : $newBalance');

        var userUpdatePatch =
            await UserUpdatePatchRepository(api: UserUpdatePatchApi())
                .getPatchUpdateRepository(
                    reqBody: {"points": newBalance.toString()});
        debugPrint('USER PATCH RESPONSE $userUpdatePatch');

        var transactionResponse =
            await TransactionPostRepository(api: TransactionPostApi())
                .postTransaction(
                    amount: _getAmount(currentPackage: event.package),
                    transactionType: transactionTypeCycling.toString());
        debugPrint(transactionResponse.toString());

        if (userUpdatePatch['result'] == 1) {
          debugPrint('User update successfully');
        } else {
          throw Exception('Update Failure');
        }

        if (transactionResponse['result'] == 1) {
          debugPrint('User update successfully');
        } else {
          throw Exception('Update Failure');
        }
      }

      emit(state.copyWith(msg: 'Service Configuration'));
      Future.delayed(const Duration(milliseconds: 1200));

      debugPrint(event.bicycle.bicycleID.toString());

      var serviceDeleteResponse =
          await ServiceDeleteRepository(api: ServiceDeleteApi())
              .deleteService(bicycleID: event.bicycle.bicycleID.toString());
      debugPrint(serviceDeleteResponse.toString());

      if (serviceDeleteResponse['result'] == 1) {
        debugPrint('Service temporary data deleted successfully');
      } else {
        await Future.delayed(const Duration(milliseconds: 1200));
        emit(state.copyWith(msg: 'Cannot Complete the service configuration'));
        throw Exception('service temporary data deleted Failure');
      }

      emit(state.copyWith(msg: 'Bicycle Configuration'));
      Future.delayed(const Duration(milliseconds: 1200));

      int bicycleRollBackResponse =
          await _bicycleStateRollBack(bicycleID: event.bicycle.bicycleID);

      double distance = Geolocator.distanceBetween(
          double.parse(state.startLang),
          double.parse(state.startLong),
          double.parse(state.endLang),
          double.parse(state.endLong));

      debugPrint('ROUTE DISTANCE : $distance');

      int pathPatchResponse = await _updatePathData(
        pathID: state.pathID,
        reqBody: {
          'endLang': state.endLang,
          'endLong': state.endLong,
          'endLocation': state.endLocation,
          'distance': distance.toString(),
        },
      );

      if ((bicycleRollBackResponse == 1) && (pathPatchResponse == 1)) {
        // db insert all rollback events
        debugPrint('PreProcesses are completed!');

        emit(state.copyWith(msg: 'Account Configuration'));

        await Future.delayed(const Duration(milliseconds: 1200));

        emit(state.copyWith(msg: 'Route Completion'));
        await Future.delayed(const Duration(milliseconds: 600));

        emit(const RideState());
        stepperBloc.add(StepperRollBackEvent());
        qrScanBloc.add(QRScanRollBackEvent());

        SqfliteHelper.instance.updateAutherization(status: 'login-verified');
        authenticationRepository.loading();
        await Future.delayed(const Duration(milliseconds: 1200));
        authenticationRepository.verified();
      } else {
        await Future.delayed(const Duration(milliseconds: 1200));
        emit(state.copyWith(
            msg: 'Cannot Complete the Route that you are involving'));
        throw Exception('Update Failure');
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(msg: 'Completion Failure'));
      await Future.delayed(const Duration(milliseconds: 1200));
      emit(state.copyWith(completeStatus: CompleteStatus.failure));
    }
  }

  Future<void> _onRideStartLocation(
    RideStartLocationDataEvent event,
    Emitter<RideState> emit,
  ) async {
    emit(state.copyWith(
      startLang: event.startLang,
      startLong: event.startLong,
      startLocation: event.startLocation,
    ));
  }

  Future<void> _onRideEndLocation(
    RideEndLocationDataEvent event,
    Emitter<RideState> emit,
  ) async {
    emit(state.copyWith(
      endLang: event.endLang,
      endLong: event.endLong,
      endLocation: event.endLocation,
    ));
  }

  Future<void> _onRideDescriptionOnChanged(
    RideDescriptionOnChanged event,
    Emitter<RideState> emit,
  ) async {
    emit(state.copyWith(
      description: event.description,
    ));
  }

  Future<void> _onRideEmergencyIDChanged(
    RideEmergencyIDChanged event,
    Emitter<RideState> emit,
  ) async {
    emit(state.copyWith(emergencyID: event.emergencyID));
  }

  bool _validatePayment(
      {required Package currentPackage, required double balance}) {
    if (currentPackage == Package.min30 && (balance >= packagePool['min30']!)) {
      return true;
    } else if (currentPackage == Package.min60 &&
        (balance >= packagePool['min60']!)) {
      return true;
    } else if (currentPackage == Package.min120 &&
        (balance >= packagePool['min120']!)) {
      return true;
    } else if (currentPackage == Package.min30 &&
        (balance >= packagePool['hour5']!)) {
      return true;
    } else {
      return false;
    }
  }

  String _getAmount({required Package currentPackage}) {
    if (currentPackage == Package.min30) {
      return packagePool['min30']!.toString();
    } else if (currentPackage == Package.min60) {
      return packagePool['min60']!.toString();
    } else if (currentPackage == Package.min120) {
      return packagePool['min120']!.toString();
    } else if (currentPackage == Package.min30) {
      return packagePool['hour5']!.toString();
    } else {
      return '00.00';
    }
  }

  int _getPackagetime({required Package currentPackage}) {
    if (currentPackage == Package.min30) {
      return packageTime['min30']!;
    } else if (currentPackage == Package.min60) {
      return packageTime['min60']!;
    } else if (currentPackage == Package.min120) {
      return packageTime['min120']!;
    } else if (currentPackage == Package.min30) {
      return packageTime['hour5']!;
    } else {
      return 0;
    }
  }

  Future<Map<String, dynamic>> _tableConfiguration({
    required String bicycleID,
    required String stationID,
    required String lang,
    required String long,
    required String station,
    required String amount,
  }) async {
    try {
      var pathResponse =
          await PathPostRepository(api: PathPostApi()).postPath(reqBody: {
        "bicycleId": bicycleID,
        "startLong": lang,
        "startLang": long,
        "startLocation": station
      });

      debugPrint(
          """
---------------------------------------

${pathResponse.toString()}

---------------------------------------

""");

      var recentActivityResponse =
          await RecentActivityPostRepository(api: RecentActivityPostApi())
              .postRecentActivity(reqBody: {
        "pathID": pathResponse['body']['path']['pathId'].toString(),
        "stationID": stationID,
        "bicycleID": bicycleID,
        "amount": amount,
      });

      debugPrint('Recent Activity has generated!');
      debugPrint(recentActivityResponse.toString());

      var bicyclePatchResponse =
          await BicyclePatchRepository(api: BicyclePatchApi())
              .bicyclePatch(bicycleID: bicycleID, bicycleStatus: '2');

      debugPrint('Bicycle Status has updated successfully!');
      debugPrint(bicyclePatchResponse.toString());

      var serviceResponse = await ServicePostRepository(api: ServicePostApi())
          .postService(reqBody: {
        "bicycleID": bicycleID,
        "pathID": pathResponse['body']['path']['pathId'].toString(),
        "recentActivityID": recentActivityResponse['body']['recentActivities']
                ['activityId']!
            .toString()
      });

      debugPrint(serviceResponse.toString());
      debugPrint('Service information has added!');

      return {
        'result': 1,
        'pathID': pathResponse['body']['path']['pathId'].toString(),
      };
    } catch (e) {
      debugPrint(e.toString());
      return {
        'result': 0,
      };
    }
  }

  Future<void> _refillAccount({
    required Package currentPackage,
  }) async {
    var userUpdatePatch = await UserUpdatePatchRepository(
            api: UserUpdatePatchApi())
        .getPatchUpdateRepository(
            reqBody: {"points": _getAmount(currentPackage: currentPackage)});
    debugPrint('USER PATCH RESPONSE $userUpdatePatch');

    if (userUpdatePatch['result'] == 1) {
      debugPrint('User update successfully');

      var transactionResponse =
          await TransactionPostRepository(api: TransactionPostApi())
              .postTransaction(
                  amount: _getAmount(currentPackage: currentPackage),
                  transactionType: '3');
      debugPrint(transactionResponse.toString());

      await Future.delayed(const Duration(milliseconds: 1200));
    }
  }

  Future<int> _bicycleStateRollBack({required String bicycleID}) async {
    var bicycleLockResponse =
        await BicyclePatchRepository(api: BicyclePatchApi())
            .bicyclePatch(bicycleID: bicycleID, bicycleStatus: '1');
    if (bicycleLockResponse['result'] == 1) {
      debugPrint(bicycleLockResponse.toString());
      debugPrint('bicycle has roll back');
      return 1;
    } else {
      debugPrint('bicycle cannot roll back');
      return 0;
    }
  }

  Future<int> _updatePathData(
      {required String pathID, required Map<String, String> reqBody}) async {
    var pathPatchResponse = await PathPatchRepository(api: PathPatchApi())
        .pathPatch(pathID: pathID, reqBody: reqBody);
    if (pathPatchResponse['result'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }
}
