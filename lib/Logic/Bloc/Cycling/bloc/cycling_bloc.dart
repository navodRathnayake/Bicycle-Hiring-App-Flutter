import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cycling_event.dart';
part 'cycling_state.dart';

class CyclingBloc extends Bloc<CyclingEvent, CyclingState> {
  CyclingBloc() : super(CyclingInitial()) {
    on<CyclingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
