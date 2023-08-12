import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Profile/View/data/data%20provider/transaction_requested_api.dart';
import 'package:final_project/Logic/Bloc/Profile/View/data/repository%20provider/transaction_repository.dart';
import 'package:flutter/material.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    on<TransactionClickedEvent>(_onTransactionClickEvent);
  }

  Future<void> _onTransactionClickEvent(
    TransactionClickedEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(state.copyWith(
      status: TransactionStatus.inProcess,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: TransactionStatus.inProcess,
    ));

    final response =
        await TransactionRequestedRepository(api: TransactionRequestedApi())
            .getLoginResponse();

    if (response['result'] == 1) {
      debugPrint(response.toString());

      emit(state.copyWith(
        transactions: response['body']['transactions'],
      ));

      debugPrint('STATE VARIABLE ');
      debugPrint(state.transactions.length.toString());

      for (int i = 0; i < state.transactions.length; i++) {
        debugPrint('\n');
        debugPrint(state.transactions[i].toString());
        debugPrint('\n');
      }

      // debugPrint(state.transactions.toString());

      // await Future.delayed(const Duration(milliseconds: 1200));

      emit(state.copyWith(
        status: TransactionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        status: TransactionStatus.failure,
      ));
    }
    // await Future.delayed(const Duration(milliseconds: 1200));

    // await Future.delayed(const Duration(milliseconds: 1200));
  }
}
