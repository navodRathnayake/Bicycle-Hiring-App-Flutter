part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountStreamChanged extends AccountEvent {
  final AccountStreamStatus status;

  const AccountStreamChanged({required this.status});

  @override
  List<Object> get props => [status];
}
