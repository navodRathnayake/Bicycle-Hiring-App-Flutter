part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ListViewEvent extends ProfileEvent {}

class ChartViewEvent extends ProfileEvent {}

class TransactionLoading extends ProfileEvent {}
