part of 'recent_activity_bloc.dart';

enum RecentActivityStatus { inProcess, success, failure, empty }

class RecentActivityState extends Equatable {
  final int selectedIndex;
  final RecentActivityStatus status;
  final List<dynamic> activities;
  final ItemScrollController itemScrollController;

  const RecentActivityState({
    this.status = RecentActivityStatus.inProcess,
    this.activities = const [],
    required this.itemScrollController,
    this.selectedIndex = 0,
  });

  RecentActivityState copyWith({
    RecentActivityStatus? status,
    List<dynamic>? activities,
    ItemScrollController? itemScrollController,
    int? selectedIndex,
  }) {
    return RecentActivityState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
      itemScrollController: itemScrollController ?? this.itemScrollController,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [status, activities, selectedIndex];
}
