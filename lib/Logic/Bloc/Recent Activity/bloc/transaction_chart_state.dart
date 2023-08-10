part of 'transaction_chart_bloc.dart';

enum TransactionChartStatus { inProcess, success, failure }

class TransactionChartState extends Equatable {
  final TransactionChartStatus status;
  final Map<String, List<int>> chart;

  const TransactionChartState({
    this.status = TransactionChartStatus.inProcess,
    this.chart = const {'': []},
  });

  TransactionChartState copyWith({
    TransactionChartStatus? status,
    Map<String, List<int>>? chart,
  }) {
    return TransactionChartState(
      status: status ?? this.status,
      chart: chart ?? this.chart,
    );
  }

  @override
  List<Object?> get props => [status, chart];
}
