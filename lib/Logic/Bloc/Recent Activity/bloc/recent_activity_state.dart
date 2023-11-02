part of 'recent_activity_bloc.dart';

enum RecentActivityStatus { inProcess, success, failure, empty }

enum RecentActivityRouteStatus { inProcess, success, failure, cancel }

class RecentActivityState extends Equatable {
  final int selectedIndex;
  final RecentActivityStatus status;
  final List<dynamic> activities;
  final int currentRecentActivityIndex;
  final ItemScrollController itemScrollController;
  final RecentActivityRouteStatus routeStatus;
  final List<LatLng> gpsPoints;
  final Map<String, dynamic> tempActivityDetails;

  const RecentActivityState({
    this.status = RecentActivityStatus.inProcess,
    this.activities = const [],
    required this.itemScrollController,
    this.selectedIndex = 0,
    this.currentRecentActivityIndex = 0,
    this.routeStatus = RecentActivityRouteStatus.inProcess,
    this.gpsPoints = const [],
    this.tempActivityDetails = const {},
  });

  RecentActivityState copyWith({
    RecentActivityStatus? status,
    List<dynamic>? activities,
    ItemScrollController? itemScrollController,
    int? selectedIndex,
    int? currentRecentActivityIndex,
    RecentActivityRouteStatus? routeStatus,
    List<LatLng>? gpsPoints,
    Map<String, dynamic>? tempActivityDetails,
  }) {
    return RecentActivityState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
      itemScrollController: itemScrollController ?? this.itemScrollController,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      currentRecentActivityIndex:
          currentRecentActivityIndex ?? this.currentRecentActivityIndex,
      routeStatus: routeStatus ?? this.routeStatus,
      gpsPoints: gpsPoints ?? this.gpsPoints,
      tempActivityDetails: tempActivityDetails ?? this.tempActivityDetails,
    );
  }

  @override
  List<Object?> get props => [
        status,
        activities,
        selectedIndex,
        currentRecentActivityIndex,
        routeStatus,
        gpsPoints,
        tempActivityDetails
      ];
}
