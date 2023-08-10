part of 'recent_activity_bloc.dart';

enum RecentActivityStatus { inProcess, success, failure }

class RecentActivityState extends Equatable {
  final RecentActivityStatus status;
  final List<Map<String, String>> activities;

  const RecentActivityState({
    this.status = RecentActivityStatus.inProcess,
    this.activities = const [],
  });

  RecentActivityState copyWith({
    RecentActivityStatus? status,
    List<Map<String, String>>? activities,
  }) {
    return RecentActivityState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
    );
  }

  @override
  List<Object?> get props => [status, activities];
}
