part of 'transaction_bloc.dart';

enum TransactionStatus { inProcess, success, failure }

class TransactionState extends Equatable {
  final TransactionStatus status;
  final List<dynamic> transactions;

  const TransactionState({
    this.status = TransactionStatus.inProcess,
    this.transactions = const [],
  });

  TransactionState copyWith({
    TransactionStatus? status,
    List<dynamic>? transactions,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [status, transactions];
}
