part of 'account_bloc.dart';

class AccountState extends Equatable {
  final User user;

  const AccountState({this.user = User.empty});

  @override
  List<Object?> get props => [user];
}
