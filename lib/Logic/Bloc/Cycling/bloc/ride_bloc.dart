import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Account/account_bloc.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/transaction_post_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/transaction_post_repository.dart';
import 'package:flutter/foundation.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final StepperBloc stepperInstance;
  final AccountBloc userAccount;
  RideBloc({required this.stepperInstance, required this.userAccount})
      : super(const RideState()) {
    on<RideInitialEvent>(_onRideInitial);
  }

  Future<void> _onRideInitial(
    RideInitialEvent event,
    Emitter<RideState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      debugPrint(userAccount.state.user.email.toString());
      debugPrint('----------------------------------------');
      debugPrint(userAccount.state.user.toString());
      debugPrint('----------------------------------------');

      if (_validatePayment(
          currentPackage: stepperInstance.state.package,
          balance: userAccount.state.user.points)) {
        debugPrint('USER HAS VALIDATED FOR THE PAYMENT');
        await Future.delayed(const Duration(milliseconds: 1200));
        emit(state.copyWith(msg: 'Payment being process'));
        debugPrint('msg : ${state.msg}');

        var response = await TransactionPostRepository(
                api: TransactionPostApi())
            .postTransaction(
                amount:
                    _getAmount(currentPackage: stepperInstance.state.package),
                transactionType: transactionTypeCycling.toString());
        debugPrint(response.toString());
      } else {
        debugPrint('USER HAS NOT VALIDATED FOR THE PAYMENT');

        emit(state.copyWith(
          msg: 'USER HAS NOT VALIDATED FOR THE PAYMENT',
          status: RideStatus.failure,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        msg: e.toString(),
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
