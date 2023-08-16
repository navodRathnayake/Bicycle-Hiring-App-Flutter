part of 'transaction_chart_bloc.dart';

sealed class TransactionChartEvent extends Equatable {
  const TransactionChartEvent();

  @override
  List<Object> get props => [];
}

class TransactionChartClickEvent extends TransactionChartEvent {}
