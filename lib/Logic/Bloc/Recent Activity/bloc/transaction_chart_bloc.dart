import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transaction_chart_event.dart';
part 'transaction_chart_state.dart';

class TransactionChartBloc
    extends Bloc<TransactionChartEvent, TransactionChartState> {
  TransactionChartBloc() : super(const TransactionChartState()) {
    on<TransactionChartClickEvent>(_onTransactionChartClickEvent);
  }

  Future<void> _onTransactionChartClickEvent(
    TransactionChartClickEvent event,
    Emitter<TransactionChartState> emit,
  ) async {
    emit(state.copyWith(
      status: TransactionChartStatus.inProcess,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: TransactionChartStatus.inProcess,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: TransactionChartStatus.success,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: TransactionChartStatus.failure,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));
  }
}
