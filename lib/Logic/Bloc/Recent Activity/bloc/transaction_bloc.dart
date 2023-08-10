import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      status: TransactionStatus.initial,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: TransactionStatus.inProcess,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: TransactionStatus.success,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: TransactionStatus.failure,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: TransactionStatus.initial,
    ));
  }
}
