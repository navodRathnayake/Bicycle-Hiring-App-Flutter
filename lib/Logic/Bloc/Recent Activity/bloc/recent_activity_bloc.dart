import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/data%20provider/gps_get_api.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/data%20provider/recent_activity_api.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/repository%20provider/gps_get_repository.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/repository%20provider/recent_activity_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:intl/intl.dart';

part 'recent_activity_event.dart';
part 'recent_activity_state.dart';

class RecentActivityBloc
    extends Bloc<RecentActivityEvent, RecentActivityState> {
  RecentActivityBloc()
      : super(
            RecentActivityState(itemScrollController: ItemScrollController())) {
    on<RecentActivityClickedEvent>(_onRecentActivityClickEvent);
    on<RecentActivityCurrentActivityChanged>(
        _onRecentActivityCurrentActivityIndexChanged);
    on<RecentActivityItemScrollController>(
        _onRecentActivityItemScrollController);
    on<RecentAcrivityViewEvent>(_onRecentActivityViewEent);
  }

  Future<void> _onRecentActivityClickEvent(
    RecentActivityClickedEvent event,
    Emitter<RecentActivityState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: RecentActivityStatus.inProcess,
      ));

      await Future.delayed(const Duration(milliseconds: 1200));

      emit(state.copyWith(
        status: RecentActivityStatus.inProcess,
      ));

      final response = await RecentActivityRepository(api: RecentActivityApi())
          .getLoginResponse();

      if (response['error'] == 404) {
        emit(state.copyWith(
          status: RecentActivityStatus.empty,
        ));
      } else {
        final List<dynamic> activities = response['body']['recentActivities'];
        debugPrint(activities.toString());
        debugPrint(activities.length.toString());

        for (int i = 0; i < activities.length; i++) {
          debugPrint('\n');
          debugPrint(activities[i].toString());
          debugPrint('\n');
        }

        final List<dynamic> recentActivityList = await getRecentActivities(
            response: response['body']['recentActivities']);

        emit(state.copyWith(
          activities: recentActivityList,
          status: RecentActivityStatus.success,
        ));

        debugPrint('--------------------------------');
        debugPrint(state.activities.toString());
        debugPrint('--------------------------------');

        debugPrint('AAAA : ${state.activities[1][2].length}');
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        status: RecentActivityStatus.failure,
      ));
    }
  }

  Future<void> _onRecentActivityItemScrollController(
    RecentActivityItemScrollController event,
    Emitter<RecentActivityState> emit,
  ) async {
    state.itemScrollController.scrollTo(
        index: event.index, duration: const Duration(milliseconds: 400));
    emit(state.copyWith(
      selectedIndex: event.index,
    ));

    debugPrint('Selected Index : ${state.selectedIndex}');
    debugPrint(event.index.toString());
  }

  Future<void> _onRecentActivityCurrentActivityIndexChanged(
    RecentActivityCurrentActivityChanged event,
    Emitter<RecentActivityState> emit,
  ) async {
    emit(state.copyWith(
      currentRecentActivityIndex: state.currentRecentActivityIndex,
    ));
  }

  Future<void> _onRecentActivityViewEent(
    RecentAcrivityViewEvent event,
    Emitter<RecentActivityState> emit,
  ) async {
    emit(state.copyWith(routeStatus: RecentActivityRouteStatus.inProcess));

    debugPrint(state.activities[event.index].toString());
    debugPrint("\n");
    debugPrint(state.activities[event.index][2][event.nested].toString());

    emit(state.copyWith(
        tempActivityDetails: state.activities[event.index][2][event.nested]));

    // (state.activities[event.index][2][event.nested]['path']['pathId'] == 25)

    var gpsResponse = await GPSGetRepository(api: GPSGetApi()).getGPSResponse(
        pathID: state.activities[event.index][2][event.nested]['path']
            ['pathId']);

    debugPrint(gpsResponse.toString());

    List<LatLng> tempGPSPoints = [];

    if (gpsResponse['result'] == 1) {
      await Future.delayed(const Duration(milliseconds: 800));

      for (int i = 0; i < gpsResponse['body']['gpsDetails'].length; i++) {
        tempGPSPoints.add(LatLng(
            double.parse(
                gpsResponse['body']['gpsDetails'][i]['gps_points_lang']),
            double.parse(
                gpsResponse['body']['gpsDetails'][i]['gps_points_long'])));
      }

      debugPrint(tempGPSPoints.toString());

      emit(state.copyWith(gpsPoints: tempGPSPoints));

      emit(state.copyWith(routeStatus: RecentActivityRouteStatus.success));

      debugPrint('Nested Activity Reads');
      debugPrint(state.tempActivityDetails.toString());
    } else {
      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(routeStatus: RecentActivityRouteStatus.failure));
    }
  }
}

Future<List<dynamic>> getRecentActivities(
    {required List<dynamic> response}) async {
  List modifiedRecentActivities = [];

  var now = DateTime.now();
  var totalDays = DateUtils.getDaysInMonth(now.year, now.month);
  var listOfDates = List<int>.generate(totalDays, (i) => i + 1);
  var listOfDateTimes =
      listOfDates.map((d) => DateTime(now.year, now.month, d)).toList();
  var dateFormat = DateFormat("yyyy-MM-dd");
  var listOfFormattedDates =
      listOfDateTimes.map((dt) => dateFormat.format(dt)).toList();
  debugPrint(listOfFormattedDates.toString());

  debugPrint(response[0]['date']);

  for (int i = 0; i < listOfFormattedDates.length; i++) {
    DateTime date = DateTime.parse(listOfFormattedDates[i]);
    final day = date.day;
    final weekName = DateFormat('EEEE').format(date);

    modifiedRecentActivities.add([day, weekName, []]);

    debugPrint(response.length.toString());

    for (int j = 0; j < response.length; j++) {
      if (listOfFormattedDates[i].toString() ==
          response[j]['date']!.toString()) {
        modifiedRecentActivities[i][2].add(response[j]);
      }
    }
  }

  for (int k = 0; k < modifiedRecentActivities.length; k++) {
    debugPrint('\n');
    debugPrint(modifiedRecentActivities[k].toString());
    debugPrint('\n');
  }

  debugPrint('AAAAAAAAAAAAAAAAAAA');
  debugPrint(modifiedRecentActivities.toString());
  return modifiedRecentActivities;
}
