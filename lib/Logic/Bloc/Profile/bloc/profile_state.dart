part of 'profile_bloc.dart';

enum TransactionDialogBox { listView, loading, chartView }

class ProfileState extends Equatable {
  final TransactionDialogBox transactionDialogBoxStatus;

  const ProfileState._({
    this.transactionDialogBoxStatus = TransactionDialogBox.listView,
  });

  const ProfileState.initial() : this._();
  const ProfileState.loadListView()
      : this._(transactionDialogBoxStatus: TransactionDialogBox.listView);
  const ProfileState.loadChartView()
      : this._(transactionDialogBoxStatus: TransactionDialogBox.chartView);
  const ProfileState.loading()
      : this._(transactionDialogBoxStatus: TransactionDialogBox.loading);

  @override
  List<Object?> get props => [transactionDialogBoxStatus];
}
