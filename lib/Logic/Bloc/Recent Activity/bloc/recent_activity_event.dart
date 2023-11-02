part of 'recent_activity_bloc.dart';

abstract class RecentActivityEvent extends Equatable {
  const RecentActivityEvent();

  @override
  List<Object> get props => [];
}

class RecentActivityClickedEvent extends RecentActivityEvent {}

class RecentActivityItemScrollController extends RecentActivityEvent {
  final int index;
  const RecentActivityItemScrollController({required this.index});
}

class RecentActivityCurrentActivityChanged extends RecentActivityEvent {
  final int currentRecentActivityIndex;
  const RecentActivityCurrentActivityChanged(
      {required this.currentRecentActivityIndex});
}

class RecentAcrivityViewEvent extends RecentActivityEvent {
  final int index;
  final int nested;
  const RecentAcrivityViewEvent({required this.index, required this.nested});
}
