import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recent_activity_event.dart';
part 'recent_activity_state.dart';

class RecentActivityBloc
    extends Bloc<RecentActivityEvent, RecentActivityState> {
  RecentActivityBloc() : super(const RecentActivityState()) {
    on<RecentActivityClickedEvent>(_onRecentActivityClickEvent);
  }

  Future<void> _onRecentActivityClickEvent(
    RecentActivityClickedEvent event,
    Emitter<RecentActivityState> emit,
  ) async {
    emit(state.copyWith(
      status: RecentActivityStatus.inProcess,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: RecentActivityStatus.inProcess,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: RecentActivityStatus.success,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      status: RecentActivityStatus.failure,
    ));

    await Future.delayed(const Duration(milliseconds: 1200));
  }
}
