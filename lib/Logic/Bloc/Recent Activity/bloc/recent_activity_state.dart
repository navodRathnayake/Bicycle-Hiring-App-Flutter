part of 'recent_activity_bloc.dart';

abstract class RecentActivityState extends Equatable {
  const RecentActivityState();
  
  @override
  List<Object> get props => [];
}

class RecentActivityInitial extends RecentActivityState {}
