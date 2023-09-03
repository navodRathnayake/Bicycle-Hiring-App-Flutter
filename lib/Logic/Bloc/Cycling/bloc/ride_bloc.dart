import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Account/account_bloc.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/transaction_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/transaction_post_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/src/validate_location.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/model/user_model.dart';
import 'package:final_project/Services/data/data%20provider/user_update_patch_api.dart';
import 'package:final_project/Services/data/repository%20provider/user_update_patch_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  RideBloc() : super(const RideState()) {
    on<RideInitialEvent>(_onRideInitial);
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

      if (_validatePayment(
          currentPackage: event.package, balance: event.user.points)) {
        debugPrint('USER HAS VALIDATED FOR THE PAYMENT');
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

          var response =
              await TransactionPostRepository(api: TransactionPostApi())
                  .postTransaction(
                      amount: _getAmount(currentPackage: event.package),
                      transactionType: transactionTypeCycling.toString());
          debugPrint(response.toString());

          await Future.delayed(const Duration(milliseconds: 1200));

          emit(state.copyWith(
            msg: 'Bicycle Configuration',
          ));
        } else {
          emit(state.copyWith(
            msg: 'Payment Process Has\nBeen Failed',
            status: RideStatus.failure,
          ));

          throw Exception('Payment Process Has\nBeen Failed');
        }
      } else {
        debugPrint('USER HAS NOT VALIDATED FOR THE PAYMENT');

        emit(state.copyWith(
          msg: 'USER HAS NOT VALIDATED FOR THE PAYMENT',
          status: RideStatus.failure,
        ));

        throw Exception('USER HAS NOT VALIDATED FOR THE PAYMENT');
      }

      // Bicycle configiration
      var response = await getCurrentLocation();
      debugPrint(response.toString());

      Map<String, dynamic> validateResult = isValidLocation(
          lang: response.latitude.toString(),
          long: response.longitude.toString(),
          stations: stations);

      debugPrint(validateResult.toString());
      if (validateResult['validate']) {
        debugPrint('LOCATION VALIDATION : PASS');
        if (_validatePayment(
            currentPackage: event.package, balance: event.user.points)) {
          // process
          debugPrint('PAYMENT Validation : PASS');
          // process
        } else {
          debugPrint('PAYMENT VALIDATION : FAIL');
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
}
