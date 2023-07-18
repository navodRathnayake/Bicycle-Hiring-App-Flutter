import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recent_activity_event.dart';
part 'recent_activity_state.dart';

class RecentActivityBloc extends Bloc<RecentActivityEvent, RecentActivityState> {
  RecentActivityBloc() : super(RecentActivityInitial()) {
    on<RecentActivityEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
