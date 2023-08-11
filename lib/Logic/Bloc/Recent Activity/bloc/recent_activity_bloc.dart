import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'recent_activity_event.dart';
part 'recent_activity_state.dart';

class RecentActivityBloc
    extends Bloc<RecentActivityEvent, RecentActivityState> {
  RecentActivityBloc()
      : super(
            RecentActivityState(itemScrollController: ItemScrollController())) {
    on<RecentActivityClickedEvent>(_onRecentActivityClickEvent);
    on<RecentActivityItemScrollController>(
        _onRecentActivityItemScrollController);
  }

  Future<void> _onRecentActivityClickEvent(
    RecentActivityClickedEvent event,
    Emitter<RecentActivityState> emit,
  ) async {
    // emit(state.copyWith(
    //   status: RecentActivityStatus.inProcess,
    // ));

    // await Future.delayed(const Duration(milliseconds: 1200));

    // emit(state.copyWith(
    //   status: RecentActivityStatus.inProcess,
    // ));

    // await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: RecentActivityStatus.success,
    ));

    // await Future.delayed(const Duration(milliseconds: 1200));

    // emit(state.copyWith(
    //   status: RecentActivityStatus.failure,
    // ));

    // await Future.delayed(const Duration(milliseconds: 1200));
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
}
