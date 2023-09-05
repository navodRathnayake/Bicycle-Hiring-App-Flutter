import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/bicycle_patch_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/path_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/recent_activity_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/transaction_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/bicycle_patch_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/path_post_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/recent_activity_post_repository.dart';
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

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final AccountStreamRepository accountStreamRepository;
  final AuthenticationRepository authenticationRepository;
  RideBloc(
      {required this.accountStreamRepository,
      required this.authenticationRepository})
      : super(const RideState()) {
    on<RideInitialEvent>(_onRideInitial);
    on<RideLockPressedEvent>(_onRideLockPressed);
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
            int tableConfigurationResponse = await _tableConfiguration(
              bicycleID: event.bicycle.bicycleID,
              lang: geolocatorResponse.latitude.toString(),
              long: geolocatorResponse.longitude.toString(),
              station: validateResult['station']!,
              amount: double.parse(_getAmount(currentPackage: event.package))
                  .toString(),
              stationID: validateResult['id'],
            );
            if (tableConfigurationResponse == 1) {
              emit(state.copyWith(msg: 'Bicycle Configuration\nHas Done'));
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

  Future<int> _tableConfiguration({
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

      return 1;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
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
}
